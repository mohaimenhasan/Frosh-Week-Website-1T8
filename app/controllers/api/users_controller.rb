require 'awesome_print' if Rails.env.development?
require 'admin_authorization'

class Api::UsersController < ActionController::Base

  include AdminAuthorization

  before_filter :authorize_admin, except:[:create, :confirm]

  def create
    # Sample: POST http://0.0.0.0:3000/api/users?discipline=Chemical&email=a@b.com&emergency_phone=4169671111&emergency_name=Fido&emergency_relationship=dog&first_name=bob&last_name=last&shirt_size=Medium&gender=Male&package_id=2&bursary_requested=false&emergency_email=c@d.com&skip_stripe=yes&skip_confirm_email=true&no_json=true
    
    user_data = 
      if params.has_key? :no_json
        params
      else
        params["user"]
      end

    new_user = User.new user_data.slice *User.accessible_attributes

    new_user.verified = false
    if params.has_key? :no_json
      new_user.bursary_requested = (user_data.has_key?(:bursary_requested) and user_data[:bursary_requested].to_bool_with_default)
    end
    new_user.bursary_chosen = nil
    new_user.bursary_paid = false

    if Rails.env.development? and user_data.has_key? :random_gender_disc
      disps = ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral']
      genders = ['Male', 'Female']
      new_user.gender = genders[rand genders.count]
      new_user.discipline = disps[rand disps.count]
    end

    if new_user.valid?

      empty_group = Group.includes(:users).where(users: {group_id: nil}).first
      new_user.group =
        if empty_group
          empty_group
        else
          Group.select("groups.name, groups.id, count(nullif(users.gender='" + new_user.gender + "', false)) AS gender_count, count(nullif(users.discipline='" + new_user.discipline + "', false)) AS disc_count, count(users.id) AS users_count").joins(:users).group('groups.name, groups.id').order('users_count ASC').order('gender_count ASC').order("disc_count ASC").first
        end

      #Useful method to check for group stats: Group.all.each {|g| p g.name.to_s << ": " << g.users.count.to_s << ", " << g.users.where(gender: 'Female').count.to_s << ", " << g.users.where(discipline:'Mineral').count.to_s}

      unless (Rails.env.development? and user_data.has_key? :skip_stripe) or new_user.bursary_requested
        result = new_user.process_payment(user_data[:cc_token])
        unless result == :success
          render json: { errors: result }, status: 422 and return
        end
      end

      unless Rails.env.development? and user_data.has_key? :skip_confirm_email
        new_user.send_confirmation
      end

      new_user.save!
      render json: { user: new_user.attributes.except('confirmation_token') }
    else
      render json: { errors: new_user.errors }, status: 422
    end
  end

  def show
    render json: { user: User.find(params[:id]) }
  end

  def index
    render json: { users: User.all }
  end

  def destroy
    User.find(params[:id]).destroy
    render json: { status: :ok }
  end

  def update
    render json: { status: :denied }
  end

  def confirm
    u = User.find(params[:id])
    u.verified = true if u.confirmation_token == params[:token]
    render json: { status: u.attributes.except('confirmation_token') }
  end

end

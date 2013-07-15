require 'awesome_print' if Rails.env.development?

class Api::UsersController < ActionController::Base

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

    new_user.bursary_requested = (user_data.has_key?(:bursary_requested) and user_data[:bursary_requested].to_bool_with_default) if params.has_key? :no_json
    new_user.bursary_chosen = nil
    new_user.bursary_paid = false

    new_user.set_random_gender_disc if Rails.env.development? and user_data.has_key? :random_gender_disc

    new_user.package = Package.find(user_data[:package_id].to_i)

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
        render json: { errors: result }, status: 422 and return unless result == :success
      end

      new_user.create_token
      new_user.create_ticket_number

      new_user.send_confirmation unless Rails.env.development? and user_data.has_key? :skip_confirm_email

      render json: { user: new_user.attributes.except('confirmation_token').merge(new_user.credit_info) }
    else
      render json: { errors: new_user.errors }, status: 422
    end
  end

  def index
    if params.has_key? :id and params.has_key? :confirmation_token
      render json: { users: User.where(params.slice(:id, :confirmation_token)) } and return
    end

    render json: { users: [] }
  end

  def update
    u = User.find(params[:id])
    if u.confirmation_token == params["user"]["confirmation_token"]
      u.verified = params["user"]["verified"]
      u.send_receipt unless u.bursary_requested
      u.save!
      render json: { user: u.attributes.except('confirmation_token').merge(u.credit_info) } and return
    end

    render json: { user: nil }
  end

end

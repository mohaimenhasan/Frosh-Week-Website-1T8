require 'awesome_print' if Rails.env.development?

class Api::UsersController < ActionController::Base

  def create  
    user_data = params["user"]

    new_user = User.new user_data.slice *User.accessible_attributes

    new_user.verified = false

    new_user.bursary_chosen = nil
    new_user.bursary_paid = false

    new_user.set_random_gender_disc if Rails.env.development? and params.has_key? :random_gender_disc

    new_user.package = Package.find(user_data[:package_id].to_s.to_i)

    if new_user.valid?

      empty_group = Group.includes(:users).where(users: { group_id: nil }).first
      new_user.group =
        if empty_group
          empty_group
        else
          Group.select("groups.name, groups.id, count(nullif(users.gender='" + new_user.gender + "', false)) AS gender_count, count(nullif(users.discipline='" + new_user.discipline + "', false)) AS disc_count, count(users.id) AS users_count").joins(:users).group('groups.name, groups.id').order('users_count ASC').order('gender_count ASC').order("disc_count ASC").first
        end

      #Useful method to check for group stats: Group.all.each {|g| p g.name.to_s << ": " << g.users.count.to_s << ", " << g.users.where(gender: 'Female').count.to_s << ", " << g.users.where(discipline:'Mineral').count.to_s}

      unless (Rails.env.development? and params.has_key? :skip_stripe) or new_user.bursary_requested
        result = new_user.process_payment(user_data[:cc_token])
        render json: { errors: result }, status: 422 and return unless result == :success
      end

      new_user.create_token
      new_user.create_ticket_number

      new_user.send_confirmation unless Rails.env.development? and params.has_key? :skip_confirm_email

      render json: {
        user: new_user.exposed_data({
          hide_confirmation_token: true,
          show_credit_info: true
        })
      }
    else
      render json: { errors: new_user.errors }, status: 422
    end
  end

  def index
    if params.has_key? :id and params.has_key? :confirmation_token
      render json: {
        users: User.where(params.slice(:id, :confirmation_token)).map { |u| u.exposed_data }
      }
      return
    end

    render json: { users: [] }
  end

  def update
    u = User.find(params[:id])
    if u.confirmation_token == params["user"]["confirmation_token"]
      u.send_receipt if !u.bursary_requested && !u.verified
      u.verified = params["user"]["verified"]
      u.save!
      render json: {
        user: u.exposed_data({
          hide_confirmation_token: true,
          show_credit_info: true
        })
      }
      return
    end

    render json: { user: nil }
  end

end

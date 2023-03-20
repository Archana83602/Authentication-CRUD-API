# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.persisted?
      # Generate a new JWT token for the user
      token = JWT.encode({user_id: resource.id}, Rails.application.secrets.secret_key_base)
      # Include the token in the response body
      render json: {
        status: {code: 200, message: 'Signed up successfully', data: resource},
        token: token
      }, status: :ok
    else
      errors = {}
        errors[:email] = user.errors[:email].first if user.errors[:email].any?
        errors[:password] = user.errors[:password].first if user.errors[:password].any?
        render json: { errors: errors }, status: :unprocessable_entity
    end
  end
end



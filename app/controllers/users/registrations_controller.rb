# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.persisted?
      # Generate a new JWT token for the user
      # Include the token in the response body
      render json: {
        status: {code: 200, message: 'Signed up successfully', data: resource}
      }, status: :ok
    else
      errors = {}
      if resource.errors[:email].any?
        errors[:email] = 'User already exists'
      else
        errors[:email] = resource.errors[:email].first if resource.errors[:email].any?
        errors[:password] = resource.errors[:password].first if resource.errors[:password].any?
      end
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end
  
end



# frozen_string_literal: true

module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    protected

    def sign_up_params
      params.permit(:email, :password, :password_confirmation, :name)
    end

    def render_create_success
      render json: {
        data: @resource.as_json
      }
    end
  end
end

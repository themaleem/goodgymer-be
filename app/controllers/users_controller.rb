# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def logged_in_user
    data = {
      user: {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        profile_completed: current_user.profile_completed
      }
    }

    if current_goodgymer
      data[:goodgymer] = {
        id: current_goodgymer.id,
        name: current_goodgymer.name,
        role: current_goodgymer.role,
        area_id: current_goodgymer.area_id
      }
    end

    render json: data
  end
end

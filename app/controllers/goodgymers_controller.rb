# frozen_string_literal: true

class GoodgymersController < ApplicationController
  before_action :authenticate_user!

  def create
    create_params = goodgymer_params.create
    @goodgymer = Goodgymer.create!(create_params)
    current_user.update!(profile_completed: true)

    render json: @goodgymer, status: :created
  end

  private

  def goodgymer_params
    @goodgymer_params ||= GoodgymerParams.new(params, current_user)
  end
end

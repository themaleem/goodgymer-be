# frozen_string_literal: true

class GoodgymerParams
  attr_reader :params, :user

  def initialize(params, user)
    @user = user
    @params = params
  end

  def create
    { role: params[:role], area_id: params[:area_id], user_id: user.id }
  end
end

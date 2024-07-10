# frozen_string_literal: true

class SessionParams
  attr_reader :params, :goodgymer

  def initialize(params, goodgymer)
    @params = params
    @goodgymer = goodgymer
  end

  def create
    date = DateTime.parse(params[:session_date_time])
    {
      name: params[:name], area_id: params[:area_id],
      registration_limit: params[:registration_limit],
      description: params[:description], date: date.to_date,
      session_type: params[:session_type], address: params[:address],
      created_by: goodgymer.id, start_time: date.strftime('%H:%M:%S')
    }
  end
end

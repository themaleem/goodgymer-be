class SessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_session, only: %i[update destroy]

  def index
    @sessions = if params[:type] == 'for_registered'
                  Session.joins(:registrations).where(registrations: { goodgymer_id: current_goodgymer.id })
                else
                  Session.includes(:registrations).all
                end

    render json: build_sessions_response(@sessions)
  end

  def create
    create_params = session_params.create
    @session = Session.create!(create_params)

    if @session.save
      render json: @session, status: :created
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize_session_ownership

    if @session.update(session_params)
      render json: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @session.destroy
    head :no_content
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    @session_params ||= SessionParams.new(params, current_goodgymer)
  end

  def authorize_session_ownership
    return if @session.created_by == current_goodgymer.id

    render json: { error: 'Not authorized to edit this Session' }, status: :forbidden
  end

  # @todo consider moving this into an options file
  def build_sessions_response(sessions)
    sessions.map do |session|
      {
        id: session.id,
        date: session.date,
        name: session.name,
        address: session.address,
        time: session.start_time,
        area_id: session.area_id,
        description: session.description,
        session_type: session.session_type,
        registration_limit: session.registration_limit,
        registration_count: session.registration_count,
        is_registered: session.registrations.exists?(goodgymer_id: current_user.goodgymer.id)
      }
    end
  end
end

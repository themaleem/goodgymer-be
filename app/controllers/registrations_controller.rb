# frozen_string_literal: true

class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_session, only: %i[create destroy]
  before_action :set_registration, only: [:destroy]

  def create
    error_text = get_eligibility_feedback
    return render json: { error: error_text }, status: :forbidden if error_text

    @registration = Registration.new(goodgymer_id: current_goodgymer.id, session: @session)

    if @registration.save
      Pairing.create!(goodgymer_id: current_goodgymer.id, session_id: @session.id) if @session.social_visit?
      render json: @registration, status: :created
    else
      render json: @registration.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @registration.destroy
    delete_pairing if @session.social_visit?

    head :no_content
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def delete_pairing
    Pairing.find_by(goodgymer_id: current_goodgymer.id, session_id: @session.id).destroy
  end

  def get_eligibility_feedback
    can_register = @session.can_register?(current_goodgymer)
    return if can_register

    if @session.social_visit?
      error_text = 'DBS verification required to register for this session'
    elsif @session.community_mission?
      error_text = 'Task-Force role required to register for community mission sessions'
    end
    error_text
  end

  def set_registration
    @registration = Registration.find_by(goodgymer_id: current_goodgymer.id, session: @session)
  end
end

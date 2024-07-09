# frozen_string_literal: true

module AuthConcerns
  extend ActiveSupport::Concern

  def current_goodgymer
    return nil unless current_user

    return @current_goodgymer if @goodgymer_fetched

    @goodgymer_fetched = true
    @current_goodgymer = current_user.goodgymer

    @current_goodgymer
  end

  # @note this will authenticate user and goodgymer instance
  # useful for Sessions and Session registrations pages where user
  # needs to have been fully registered to be able to interact those pages
  def authenticate_goodgymer!
    current_goodgymer
  end
end

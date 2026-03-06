class WelcomeUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    Rails.logger.info "Welcome #{user.name}! Your account has been created."
  end
end

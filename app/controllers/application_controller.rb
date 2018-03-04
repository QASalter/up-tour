class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :time_check

  def time_check
    time = TimeCheck.find(1)
    UpdateDbJob.perform_later if time.last_checked < 10.minutes.ago
  end
end

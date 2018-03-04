class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :time_check

  def time_check
    time = TimeCheck.where(id: 1).first_or_create do |time|
      time.last_checked = 15.minutes.ago
    end

    UpdateDbJob.perform_later if time.last_checked < 10.minutes.ago
  end
end

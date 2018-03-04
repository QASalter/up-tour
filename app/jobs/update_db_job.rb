class UpdateDbJob < ApplicationJob
  queue_as :default

  def perform
    TimeCheck.where(id: 1).first_or_create do |time|
      time.last_checked = Time.now
    end
    ApplicationHelper.get_csv
    Club.update_clubs
    Team.update_team
  end
end

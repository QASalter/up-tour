class UpdateDbJob < ApplicationJob
  queue_as :default

  def perform
    time = TimeCheck.find(1)
    time.update!(last_checked: Time.now)

    ApplicationHelper.get_csv
    Club.update_clubs
    Team.update_team
  end
end

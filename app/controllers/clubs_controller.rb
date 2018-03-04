class ClubsController < ApplicationController
  def show
    @team = Team.where(club_id: params[:id])
  end
end

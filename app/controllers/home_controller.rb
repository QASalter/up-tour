class HomeController < ApplicationController
  def index
    @club = Club.all
  end
end

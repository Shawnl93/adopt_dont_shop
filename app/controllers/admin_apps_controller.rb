class AdminAppsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

end

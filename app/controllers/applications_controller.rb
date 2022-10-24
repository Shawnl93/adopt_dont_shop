class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.create(app_params)
    redirect_to "/applications/#{application.id}"
  end

private

  def app_params
    params[:application_status] = "In Progress"
    params.permit(:name, :street, :city, :state, :zip_code, :description, :application_status)
  end
end

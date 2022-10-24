class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

private

  def app_params
    params[:application_status] = "In Progress"
    params.permit(:name, :street, :city, :state, :zip_code, :description, :application_status)
  end
end

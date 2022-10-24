class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.create(app_params)
    binding.pry
    redirect_to "/applications/#{application.id}"
  end

private

  def app_params
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end
end

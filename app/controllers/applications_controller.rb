class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = Pet.adoptable
    end
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

  def update
    application = Application.find(params[:id])
    if params[:commit] == "Submit application"
      application[:application_status] = "Pending"
      application[:description] = params[:"Why I am a good owner"]
      application.save
    else
      pet = Pet.find(params[:pet])
      application.pets << pet
      application.save
    end
      redirect_to "/applications/#{application.id}"
  end

private

  def app_params
    params[:application_status] = "In Progress"
    params.permit(:name, :street, :city, :state, :zip_code, :description, :application_status)
  end
end

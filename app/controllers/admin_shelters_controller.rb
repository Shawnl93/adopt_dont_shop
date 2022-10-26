class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_name
  end
end

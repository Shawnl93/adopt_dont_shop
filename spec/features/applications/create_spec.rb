require 'rails_helper'

RSpec.describe "Makes new applications" do
  describe "When i visit a pet's index page" do
    it "has a link to Start an application" do
      visit '/pets'
      click_on "Start an Application"
      expect(current_path).to eq('/applications/new')
    end

    it "can make a new applicant" do
      visit '/applications/new'
      fill_in :name, with: "Shawn 2.0"
      fill_in :street, with: "123 the st."
      fill_in :city, with: "MyCity"
      fill_in :state, with: "United States"
      fill_in :zip_code, with: "55555"
      fill_in :description, with: "im better than Shawn 1.0"
      click_on "Submit"
      shawn2 = Application.last.id
      expect(current_path).to eq("/applications/#{shawn2}")
      expect(page).to have_content("In Progress")
    end

    it "" do

    end
  end
end

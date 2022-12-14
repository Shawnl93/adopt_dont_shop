require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  describe "When i visit the admin shelter index" do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      @Shawn = Application.create!(name: "Shawn", street: "123 Turing st.", city: "Denver", state: "CO", zip_code: '80000', description: "pet lover", application_status: "In Progress")
      @Shawn2 = Application.create!(name: "Shawn2", street: "345 Turing st.", city: "Denver2", state: "CO2", zip_code: '80000', description: "pet lover2", application_status: "Pending")
      @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @clawdia = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @Shawn.pets << @pirate
      @Shawn2.pets << @clawdia
      visit "/admin/shelters"
    end

    it "shelter listed in reverse alphabetical order" do
      expect(page).to have_content("Admin Shelter")
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end

    it "Name of every shelter with pending application" do
      expect(page).to have_content("Shelter's with Pending Applications")
      expect(page).to have_content(@shelter_2.name)
    end
  end
end

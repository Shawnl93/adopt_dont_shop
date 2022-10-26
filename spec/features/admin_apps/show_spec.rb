require 'rails_helper'

RSpec.describe 'the admin application show' do
  describe "When I visit the admin application show " do
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
      visit "/admin/apps/#{@Shawn.id}"
    end

    it "Buttom to Approve application for specific pet" do
      expect(page).to have_content("Admin Application")
      click_button("Approve #{@pirate.name}")
      expect(current_path).to eq("/admin/apps/#{@Shawn.id}")
      expect(page).to_not have_button("Approve Pirate")
      expect(page).to have_content("Approved")
    end
  end
end

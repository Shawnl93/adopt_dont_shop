require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @Shawn = Application.create!(name: "Shawn", street: "123 Turing st.", city: "Denver", state: "CO", zip_code: '80000', description: "pet lover", application_status: "In Progress")
    @Shawn.pets << @pirate
    @Shawn.pets << @clawdia
    visit "/applications/#{@Shawn.id}"
  end

  describe 'application show page' do
    it "Shows the applicant's attributes" do
      expect(page).to have_content(@Shawn.name)
      expect(page).to have_content(@Shawn.street)
      expect(page).to have_content(@Shawn.city)
      expect(page).to have_content(@Shawn.state)
      expect(page).to have_content(@Shawn.zip_code)
      expect(page).to have_content(@Shawn.description)
      expect(page).to have_content(@Shawn.application_status)
    end

    it "shows pets that application is for" do
      expect(page).to have_content(@pirate.name)
      expect(page).to have_content(@clawdia.name)
    end

    it "pet name links to their show page" do
      click_on("Mr. Pirate")
      expect(current_path).to eq("/pets/#{@pirate.id}")
    end

    it "section to submit application" do
      save_and_open_page
      fill_in "Why I am a good ownder", with: "Im the best"
      click_button("Submit application")
      expect(current_path).to eq("/applications/#{@Shawn.id}")

      expect(page).to have_content("Pending")
      expect(page).to have_content(@pirate.name)
      expect(page).to have_content(@clawdia.name)
      expect(page).to_not have_button("Adopt this Pet")

    end
  end
end

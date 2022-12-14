require 'rails_helper'

RSpec.describe 'application show page' do
  describe 'application show page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_2.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @Shawn = Application.create!(name: "Shawn", street: "123 Turing st.", city: "Denver", state: "CO", zip_code: '80000', description: "pet lover", application_status: "In Progress")
    @Shawn.pets << @pirate
    @Shawn.pets << @clawdia
    visit "/applications/#{@Shawn.id}"
  end

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


    it "when no application submited, see section to add pet to application" do
      expect(page).to have_content("Add A Pet to this Application")
    end

    it "can search for pet by name" do
      fill_in 'Search', with: 'Lucille Bald'
      click_on("Search")
      expect(current_path).to eq("/applications/#{@Shawn.id}")
      expect(page).to have_content(@lucille.name)
    end

    it "Button next to each pet" do
      fill_in 'Search', with: 'Lucille Bald'
      click_on("Search")
      expect(current_path).to eq("/applications/#{@Shawn.id}")
      expect(page).to have_content(@lucille.name)
      click_button("Adopt this Pet")
      expect(current_path).to eq("/applications/#{@Shawn.id}")
      expect(page).to have_link(@lucille.name)
    end

    it "section to submit application" do
      fill_in "Why I am a good owner", with: "Im the best"
      click_button("Submit application")
      expect(current_path).to eq("/applications/#{@Shawn.id}")

      expect(page).to have_content("Pending")
      expect(page).to have_content(@pirate.name)
      expect(page).to have_content(@clawdia.name)
      expect(page).to_not have_button("Adopt this Pet")
    end

    it "can search by partials" do
      fill_in "Search", with: "Lu"
      click_on("Search")
      expect(current_path).to eq("/applications/#{@Shawn.id}")
      expect(page).to have_content(@lucille.name)
    end

    it "can search case sensitive" do
      fill_in "Search", with: "luC"
      click_on("Search")
      expect(current_path).to eq("/applications/#{@Shawn.id}")
      expect(page).to have_content(@lucille.name)
    end
  end

  describe "No pet added to application" do
    it "does not see a section to submit my application" do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @clawdia = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @lucille = @shelter_2.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      @Shawn = Application.create!(name: "Shawn", street: "123 Turing st.", city: "Denver", state: "CO", zip_code: '80000', description: "pet lover", application_status: "In Progress")
      visit "/applications/#{@Shawn.id}"
      expect(page).to_not have_button("Submit application")
      first(:button, "Adopt this Pet").click
      expect(page).to have_button("Submit application")
    end
  end
end

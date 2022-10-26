# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
@Shawn = Application.create!(name: "Shawn", street: "123 Turing st.", city: "Denver", state: "CO", zip_code: '80000', description: "pet lover", application_status: "In Progress")
@Shawn2 = Application.create!(name: "Shawn2", street: "345 Turing st.", city: "Denver2", state: "CO2", zip_code: '80000', description: "pet lover2", application_status: "Pending")
@pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@clawdia = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@Shawn.pets << @pirate
@Shawn2.pets << @clawdia

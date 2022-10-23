require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @application = Application.create!(name: "Shawn", address: "123 Turing st., Denver, CO 80000", street: "123 Turing st.", city: "Denver", state: "CO", zip_code: '80000', description: "pet lover", application_status: "In Progress")
  end

  describe 'application show page' do
    it "Shows the applicant's attributes" do
    end
  end
end

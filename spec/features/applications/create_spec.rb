require 'rails_helper'

RSpec.describe "Makes new applications" do
  describe "When i visit a pet's index page" do
    it "has a link to Start an application" do
      visit '/pets'
      click_on "Start an Application"
      expect(current_path).to eq('/applications/new')
    end
  end
end

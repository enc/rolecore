require 'spec_helper'

describe MasterController do
  render_views
  describe "GET 'root'" do
    it "should be successful" do
      get 'root'
      response.should be_success
    end
  end

  describe "2 roles" do
    it "show them" do
      Factory.create(:role, :name => "Rolle1")
      Factory.create(:role, :name => "Rolle2")
      visit root_path
      page.should have_content("Rolle1")
      page.should have_content("Rolle2")
    end
  end

end

require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Twitterish 2'" do
      visit '/static_pages/home'
      page.should have_content('Twitterish 2')
    end

  end
 
  describe "Help page" do
    it "should have thet content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
  end
end

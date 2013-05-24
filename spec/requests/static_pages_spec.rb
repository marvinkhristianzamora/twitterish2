require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Twitterish 2'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Twitterish 2')
    end
    
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Twitterish 2 | Home") 
    end
  end
 
  describe "Help page" do
    it "should have thet content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end
    
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "Twitterish 2 | Help") 
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About Us')
    end
    
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "Twitterish 2 | About") 
    end
  end

  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', :text => 'Contact Us')
    end
    
    it "should have the right title" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "Twitterish 2 | Contact Us") 
    end
  end
end

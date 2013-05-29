require 'spec_helper'

describe "Static pages" do

  let(:title) { 'Twitterish 2' }
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content("#{title}") }
    it { should have_title("#{title}") }
    it { should_not have_title("| Home") }
  end
 
  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title("#{title} | Help") } 
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About Us') }
    it { should have_title("#{title} | About") }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact Us') }
    it { should have_title("#{title} | Contact Us") }
  end
end

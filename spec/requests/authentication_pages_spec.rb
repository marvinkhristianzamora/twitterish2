require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }
    
    it { should have_content("Sign in") }
    it { should have_title("Sign in")}
  end

  describe "signin" do
    before { visit signin_path }

    let(:signin) { "Sign in" }

    describe "with invalid information" do
      before { click_button signin }

      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_signin(user) }     

      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }

      describe "followed by sign out" do
        before { click_link 'Sign out' }
        it { should have_link 'Sign in', href: signin_path }
      end

    end
  end
end

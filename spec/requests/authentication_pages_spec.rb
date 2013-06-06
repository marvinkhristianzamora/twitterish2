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
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link 'Sign in', href: signin_path }

      describe "followed by sign out" do
        before { click_link 'Sign out' }
        it { should have_link 'Sign in', href: signin_path }
      end

    end
  end

  describe "authentication" do
    describe "for signed-out users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_link('Sign in', href: signin_path) }
          it { should_not have_title(full_title('Edit user')) }
        end

        describe "submitting to the update_action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "trying to visit a protected page" do
        before do
          visit edit_user_path(user)
          valid_signin(user)
        end

        describe "after signing in" do
          it "should redirect to the desired protected page" do
            expect(page).to have_title(full_title('Edit user'))
          end
        end
      end

      describe "visiting the user index" do
        before { visit users_path }
        it { should have_title('Sign in') }
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@email.com") }

      before { valid_signin(user) }
      
      describe "editing a different user" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title('Edit user')) }
      end

      describe "submitting a PATCH request to the User#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end

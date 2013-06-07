require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      valid_signin FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Dos", email: "dos@email.com")
      FactoryGirl.create(:user, name: "Tres", email: "tres@email.com")
      visit users_path
    end

    it { should have_title(full_title('All users')) }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
         expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
     
     it { should_not have_link('delete') } 

     describe "as admin user" do
       let(:admin) { FactoryGirl.create(:admin) }

       before do
         valid_signin admin
         visit users_path
       end

         it { should have_link('delete', href: user_path(User.first)) }
         it "should be able to delete another user" do
           expect { click_link('delete', href: user_path(User.first)) }.to change(User, :count).by(-1)
         end
         it { should_not have_link('delete', href: user_path(admin)) }
     end
    end
  end

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { should have_content("Sign up") }
    it { should have_title(full_title('Sign up')) }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('errors') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Marvin"
        fill_in "Email", with: "marvin@email.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }
        let(:user) { User.find_by(email: "marvin@email.com") }

        it { should have_link('Sign out', href: signout_path) }
        it { should have_title(user.name) }
        it { should have_success_message('Welcome to Twitterish 2') }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) } 
    before { visit user_path(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      valid_signin(user)
      visit edit_user_path(user) 
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content("error")}
    end

    describe "with valid information" do
      let(:new_name) { "Marvin Khristian" }
      let(:new_email) { "marvin@newemail.com" }

      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: "password"
        fill_in "Confirm Password", with: "password"
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_success_message("Profile updated") }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
    
    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password, password_confirmation: user.password } }
      end

      before { patch user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end
  end

end

require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content("error") }
      end
    end

    describe "with valid information" do
      before { fill_in "micropost_content", with: "Test Micropost" }
      it "should create a new micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost deletion" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as incorrect user" do
      let(:incorrect_user) { FactoryGirl.create(:user) }
      before do
        valid_signin incorrect_user
        visit user_path(user)
      end

      it "should not have delete links" do
        expect(page).not_to have_link("delete")
      end
    end
  end
end

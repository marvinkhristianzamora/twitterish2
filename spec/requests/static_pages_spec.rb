require 'spec_helper'

describe "Static pages" do

  let(:title) { 'Twitterish 2' }
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(page_title) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { "#{title}" }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title("| Home") }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "with multiple posts" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Post 1")
          FactoryGirl.create(:micropost, user: user, content: "Post 2")
          valid_signin user
          visit root_path
        end

        it "should contain user posts" do
          user.feed.each do |post|
            expect(page).to have_selector("li##{post.id}", text: post.content)
          end
        end

        it  "should contain user posts count" do
          expect(page).to have_content("microposts")
          expect(page).to have_content("#{user.microposts.count}")
        end
      end

      describe "with single post" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Post 1")
          valid_signin user
          visit root_path
        end

        it "should contain singular micropost text" do
          expect(page).to have_content("#{user.microposts.count}")
          expect(page).to have_content("micropost")
          expect(page).not_to have_content("microposts")
        end
      end
    end
  end
 
  describe "Help page" do
    before { visit help_path }

    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) { 'Contact Us' }
    let(:page_title) { 'Contact Us' }

    it_should_behave_like "all static pages"
  end

  it "should have the correct links in the page" do
    visit root_path
    click_link "Home"
    should have_title(full_title(''))
    click_link "Help"
    should have_title('Help')
    click_link "About"
    should have_title(full_title('About'))
    click_link "Contact"
    should have_title('Contact Us')
    click_link "Home"
    click_link "Sign up now!"
    should have_title(full_title('Sign up'))
  end
end

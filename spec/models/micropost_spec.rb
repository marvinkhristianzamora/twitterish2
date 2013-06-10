require 'spec_helper'

describe Micropost do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Test Micropost") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user id is nil" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @micropost.content = nil }
    it { should_not be_valid }
  end

  describe "when content is > than 140 characters" do
    before { @micropost.content = "x" * 141 }
    it { should_not be_valid }
  end
end

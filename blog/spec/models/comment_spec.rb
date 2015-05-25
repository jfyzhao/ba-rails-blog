require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:comment)).to be_truthy
  end
  it "is invalid without a commenter" do
    expect(FactoryGirl.build(:comment, commenter: nil)).not_to be_falsey
  end
  it "is invalid without a body" do
    expect(FactoryGirl.build(:comment, body: nil)).not_to be_falsey
  end  
end

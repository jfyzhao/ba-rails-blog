require 'rails_helper'

RSpec.describe Article, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:article)).to be_truthy
  end
  it "is invalid without a title" do
    expect(FactoryGirl.build(:article, title: nil)).not_to be_falsey
  end
  it "is invalid without text" do
    expect(FactoryGirl.build(:article, text: nil)).not_to be_falsey
  end
end

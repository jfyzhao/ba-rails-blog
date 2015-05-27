require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  # Testing DELETE methods
  describe "DELETE #destroy" do
    before :each do
      @article = FactoryGirl.create(:article)
      @comment = FactoryGirl.create(:comment)
    end

    it "deletes the comment" do
      expect{
        delete :destroy, id: @comment
      }.to change(Comment,:count).by(-1)
    end
  end
end

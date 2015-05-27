require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  # Testing DELETE methods
  describe "DELETE #destroy" do
    it "deletes the comment" do
      article = FactoryGirl.create(:article)
      expect{
        delete :destroy, {article_id: article.id, :comment => FactoryGirl.attributes_for(:comment)}
      }.to change(Comment,:count).by(-1)
    end
  end
end

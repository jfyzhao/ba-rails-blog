require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  # Testing GET methods
  describe "GET #index" do
    it "populates list of comments for the article" do
      article = FactoryGirl.create(:article)
      @comment = FactoryGirl.create(:comment, :article_id => article.id)
      get :index, comment: @comment, article_id: article.id
      expect(assigns(:comments)).to eq([@comment])
    end

    it "renders the comments index view" do
      article = FactoryGirl.create(:article)
      @comment = FactoryGirl.create(:comment, :article_id => article.id)
      get :index, comment: @comment, article_id: article.id
      expect(response).to render_template("index")
    end
  end
 
  # Testing POST methods
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new comment" do
        article = FactoryGirl.create(:article)
        @comment_attributes = FactoryGirl.attributes_for(:comment, :article_id => article.id)
        expect{
          post :create, comment: @comment_attributes, article_id: article.id
        }.to change(Comment,:count).by(1)
      end

      it "redirects to comments list" do
        article = FactoryGirl.create(:article)
        @comment_attributes = FactoryGirl.attributes_for(:comment, :article_id => article.id)
        post :create, comment: @comment_attributes, article_id: article.id
        expect(response).to redirect_to article_comments_path(article)
      end
    end

    context "with invalid attributes" do
      it "doesnt save the new comment" do
        article = FactoryGirl.create(:article)
        @comment_attributes = FactoryGirl.attributes_for(:invalid_comment, :article_id => article.id)
        expect{
          post :create, comment: @comment_attributes, article_id: article.id
        }.not_to change(Comment,:count)
      end

      it "redirects to comments list" do
        article = FactoryGirl.create(:article)
        @comment_attributes = FactoryGirl.attributes_for(:invalid_comment, :article_id => article.id)
        post :create, comment: @comment_attributes, article_id: article.id
        expect(response).to redirect_to article_comments_path(article)
      end      
    end        
  end  

  # Testing DELETE methods
  describe "DELETE #destroy" do
    it "deletes the comment" do
      article = FactoryGirl.create(:article)
      @comment = FactoryGirl.create(:comment, :article_id => article.id)
      expect{
        delete :destroy, { id: @comment, article_id: article.id }
      }.to change(Comment,:count).by(-1)
    end
  end
end

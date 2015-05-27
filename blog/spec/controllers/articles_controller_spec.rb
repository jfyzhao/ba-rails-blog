require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  # Testing GET methods
  describe "GET #index" do
    it "populates list of articles" do
      @article = FactoryGirl.create(:article)
      get :index
      expect(assigns(:articles)).to eq([@article])
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "renders the new article view" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #show" do
    it "assigns requested article to @article" do
      @article = FactoryGirl.create(:article)
      get :show, id: @article
      expect(assigns(:article)).to eq(@article)
    end

    it "renders the selected article" do
      get :show, id: FactoryGirl.create(:article)
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    it "assigns requested article to @article" do
      @article = FactoryGirl.create(:article)
      get :show, id: @article
      expect(assigns(:article)).to eq(@article)
    end
          
    it "renders the edit view" do
      get :edit, id: FactoryGirl.create(:article)
      expect(response).to render_template("edit")
    end
  end


  # Testing POST methods
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new article" do
        expect{
          post :create, article: FactoryGirl.attributes_for(:article)
        }.to change(Article,:count).by(1)
      end

      it "redirects to the new article" do
        post :create, article: FactoryGirl.attributes_for(:article)
        expect(response).to redirect_to Article.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new article" do
        expect{
          post :create, article: FactoryGirl.attributes_for(:invalid_article)
        }.not_to change(Article,:count)
      end

      it "re-renders new method" do
        post :create, article: FactoryGirl.attributes_for(:invalid_article)
        expect(response).to render_template("new")
      end
    end        
  end


  # Testing PUT methods
  describe "PUT #update" do
    before :each do
      @article = FactoryGirl.create(:article, title: "Sample Article Title", text: "Sample Article Text")
    end

    context "with valid attributes" do
      it "located the requested article" do
        put :update, id: @article, article: FactoryGirl.attributes_for(:article)
        expect(assigns(:article)).to eq(@article)
      end

      it "updates the article's attributes" do
        put :update, id: @article,
          article: FactoryGirl.attributes_for(:article, title: "Updated Title", text: "Updated text")
        @article.reload
        expect(@article.title).to eq("Updated Title")
        expect(@article.text).to eq("Updated text")
      end

      it "renders the updated article" do
        put :update, id: @article, article: FactoryGirl.attributes_for(:article)
        expect(response).to redirect_to @article
      end
    end

    context "with invalid attributes" do
      it "locates the requested article" do
        put :update, id: @article, article: FactoryGirl.attributes_for(:invalid_article)
        expect(assigns(:article)).to eq(@article)
      end

      it "does not update the article's attributes" do
        put :update, id: @article,
          article: FactoryGirl.attributes_for(:article, title: nil, text: "Updated text")
        @article.reload
        expect(@article.title).not_to eq("Updated Title")
        expect(@article.text).not_to eq("Updated text")
      end

      it "re-renders the edit view" do
        put :update, id: @article, article: FactoryGirl.attributes_for(:invalid_article)
        expect(response).to render_template :edit
      end
    end
  end


  # Testing DELETE methods
  describe "DELETE #destroy" do
    before :each do
      @article = FactoryGirl.create(:article)
    end

    it "deletes the article" do
      expect{
        delete :destroy, id: @article
      }.to change(Article,:count).by(-1)
    end

    it "redirects to article path" do
      delete :destroy, id: @article
      expect(response).to redirect_to(articles_path)
    end
  end
end
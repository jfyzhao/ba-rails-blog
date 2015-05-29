class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])

    @ip = request.remote_ip.to_s
    @bttn_display = lookup_or_save(@ip, @article.id)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end
   
  def create
    @article = Article.new(article_params)
   
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end

  # Saves the like or unlike on click of the like button
  def save_vote
    # Need to reinitialize all instance vars here since not using sessions
    @article = Article.find(params[:id])
    @ip = request.remote_ip.to_s
    @bttn_display = lookup_or_save(@ip, @article.id)
    # If a user hasn't liked a post
    if @bttn_display == 0
      # Updates or creates a new row
      like = Like.find_or_initialize_by(user: @ip, article_id: @article.id, liked: 0)
      like.update(liked:1)
      @bttn_display = 1

    # If a user has liked a post
    else
      # Find the post and updates
      Like.find_by(user: @ip, article_id: @article.id).update(liked: 0)
      @bttn_display = 0
    end
    redirect_to article_path(@article)
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    # Looks up if there already exists a like for an entry
    # and returns 1 if there is
    def lookup_or_save(ip,article_id)
      search = Like.find_by(user: @ip, article_id: @article.id)
      if (search == nil || search.liked == 0)
        return 0
      else
        return 1
      end
    end
end

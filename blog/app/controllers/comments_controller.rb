class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments.all
    @ip = request.remote_ip.to_s
    #@bttn_display = lookup_like(@ip, @comment.id)

    @bttn_display = []
    for comment in @comments
      @bttn_display.push(lookup_like(@ip, comment.id))
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_comments_path(@article)
  end
 
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_comments_path(@article)
  end

  # Saves the like or unlike on click of the like button
  def save_vote
    # Need to reinitialize all instance vars here since not using sessions
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @ip = request.remote_ip.to_s
    @bttn_display = lookup_like(@ip, @comment.id)
    # If a user hasn't liked a comment
    if @bttn_display == 0
      # Updates or creates a new row
      like = Like.find_or_initialize_by(user: @ip, comment_id: @comment.id, liked: 0)
      like.update(liked:1)
      @bttn_display = 1

    # If a user has liked a comment
    else
      # Find the comment and updates
      Like.find_by(user: @ip, comment_id: @comment.id).update(liked: 0)
      @bttn_display = 0
    end
    redirect_to article_comments_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

    # Looks up if there already exists a like for an entry
    # and returns 1 if there is
    def lookup_like(ip,comment_id)
      search = Like.find_by(user: ip, comment_id: comment_id)
      if (search == nil || search.liked == 0)
        return 0
      else
        return 1
      end
    end
end
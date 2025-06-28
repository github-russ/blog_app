class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to article_path(@article), notice: "Successfully added a comment"
    else
      flash[:notice] = "Failed to add a comment."
      render "articles/show", status: :unprocessable_entity
    end
  end

  def index; end

  def show; end

  def edit; end

  def update   
    if @comment.update(comment_params)
      redirect_to article_comment_path(@article, @comment), notice: "Successfully edited a comment."
    else
      flash[:notice] = "Failed to edit a comment."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Deleted a comment."
    redirect_to article_comments_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end

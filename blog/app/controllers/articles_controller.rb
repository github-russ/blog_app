class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end
  
  def show 
    @comment = @article.comments.build
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path, notice: "An article has been created."
    else
      flash[:notice] = "Failed to create an article."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update

    if @article.update(article_params)
      redirect_to @article, notice: "Successfully updated an article."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :see_other, notice: "Deleted an article."
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end 
end

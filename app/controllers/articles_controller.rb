class ArticlesController < ApplicationController
  
  # GET /articles/new
  def new 
    @article = Article.new
  end
  
  # POST /articles
  def create 
    @article = User.find(session[:current_user_id]).articles.build(params[:article])

    if @article.save
      flash[:article] = @article
      
      redirect_to article_path(@article.id)
    else 
      render 'new'
    end
  end
  
  # GET /articles/:id
  def show 
    @article = Article.find(params[:id])
  end

  # GET /articles
  def index
    @articles = User.find(session[:current_user_id]).articles
  end

  # GET /articles/delete/:id
  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  # GET /article/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # PUT /articles/:id
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to article_path(params[:id])
    else
      redirect_to edit_article_path(params[:id])
    end
  end

end

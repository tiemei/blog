ArticlesController < ApplicationController
  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new

    if @article.save
      render
    else 
      render 'new'
    end
  end
end

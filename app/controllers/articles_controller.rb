class ArticlesController < ApplicationController
  
  # GET /articles/new
  def new 
    @article = Article.new
  end
  
  # POST /articles
  def create 
    logger.debug "========step1 in articles#create #{flash.inspect}"
    logger.debug session[:current_user]
    @article = session[:current_user].articles.build(params[:article])

    if @article.save
      flash[:article] = @article
      flash[:n] = 'dfasdfds'
      
      #render article_path(@article.id)
      logger.debug "========step2 in articles@create #{flash.inspect}"
      logger.debug session[:current_user]
      redirect_to article_path(@article.id)
    else 
      render 'new'
    end
  end
  
  # GET /articles/:id
  def show 
    logger.debug "========in articles#show #{flash.inspect}"
    logger.debug session[:current_user]
    @article = Article.find(params[:id])
  end
end

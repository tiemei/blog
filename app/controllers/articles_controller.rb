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
    # 每月文章
    @month_list = sort_by_month(@articles)
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

  # 获取某月的文章
  # GET /articles/month/:month
  def month
    @articles = []
    articles_all = User.find(session[:current_user_id]).articles
    articles_all.each do |a|
      key = a.created_at.year.to_s + '-' + a.created_at.month.to_s
      if key == params[:month]
        @articles.push(a)
      end
    end
    # 每月文章
    @month_list = sort_by_month(articles_all)
    render 'index'
  end

  private 
  def sort_by_month(articles)
    month_list = {} # {"2013-4" => 4, "2013-5" => 5, ..}
    articles.each do |a|
      key = a.created_at.year.to_s + '-' + a.created_at.month.to_s 
      if month_list[key]
        month_list[key] = month_list[key] + 1
      else
        month_list[key] = 1
      end
    end
    month_list.sort do |a,b|
      b[0] <=> a[0]
    end
  end

end

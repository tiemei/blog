class ArticlesController < ApplicationController
  
  # GET /articles/new
  def new 
    @article = Article.new
  end
  
  # POST /articles
  def create 
    @article = User.find(session[:current_user_id]).articles.build(params[:article])

    if @article.save
      # TODO 事务控制
      # 逗号分隔的tag分别存表
      for tag in params[:tags].split(',') do
        tag = @article.tags.build({"name"=>tag})
        tag.user_id = session[:current_user_id]

        if not tag.save
          render 'new'
        end
      end
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
    user = User.find(session[:current_user_id])
    @articles = user.articles
    # 每月文章
    @month_list = Article.sort_by_month(@articles)
    # 用户所有标签 
    @tags = Tag.user_tag(session[:current_user_id])
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
      # 与已有的tag去重
      now_tags_name = []
      @article.tags.each do |tag|
        now_tags_name << tag.name
      end
      new_tags_name = params[:tags].split(',') - now_tags_name

      # 逗号分隔的tag分别存表
      for tag in new_tags_name do
        tag = @article.tags.build({"name"=>tag})
        tag.user_id = session[:current_user_id]

        if not tag.save
          redirect_to edit_article_path(params[:id])
        end
      end
      redirect_to article_path(params[:id])
    else
      redirect_to edit_article_path(params[:id])
    end
  end

  # 获取某月的文章
  # GET /articles/month/:month
  def month
    @articles = []
    user = User.find(session[:current_user_id])
    articles_all = user.articles
    articles_all.each do |a|
      key = a.created_at.year.to_s + '-' + a.created_at.month.to_s
      if key == params[:month]
        @articles.push(a)
      end
    end
    # 每月文章
    @month_list = Article.sort_by_month(articles_all)
    # 用户标签
    @tags = Tag.user_tag(session[:current_user_id])
    render 'index'
  end
end

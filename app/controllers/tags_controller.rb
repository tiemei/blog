class TagsController < ApplicationController
  # GET /tags/:tag
  def show
    # 主区文章
    user = User.find(session[:current_user_id])
    @articles = user.articles.select do |article|
      contained = false
      article.tags.each do |tag| 
        contained = true and break if params[:tag] == tag.name
      end
      contained
    end

    # 按月分类文章
    @month_list = Article.sort_by_month(user.articles)
    # 标签分类 
    @tags = Tag.user_tag(session[:current_user_id])
    render 'articles/index'
  end 
end

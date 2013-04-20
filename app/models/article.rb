class Article < ActiveRecord::Base
  attr_accessible :comment_num, :content, :title, :view_num

  # ++++++++++++++++++++
  # validation
  # ++++++++++++++++++++
  validates :content, :presence => true
  validates :title, :presence => true
  validates :comment_num, :numericality => { :only_integer => true }
  validates :view_num, :numericality => { :only_integer => true }
  
  # 验证唯一性，应用层面，多个db conn还是会重复
  validates :title, :uniqueness => true


  # ++++++++++++++++++++
  # association
  # ++++++++++++++++++++

  belongs_to :user
  # belongs_to 赋值不会自动save
  has_many :tags, :dependent => :delete_all

  # ++++++++++++++++++++
  # query api
  # ++++++++++++++++++++
  def Article.sort_by_month(articles)
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
  
  def Article.join_tags(article_id)
    result = []
    Article.find(article_id).tags.each do |tag|
      result << tag.name
    end
    result.join(',')
  end

end

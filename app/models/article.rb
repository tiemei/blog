class Article < ActiveRecord::Base
  attr_accessible :comment_num, :content, :title, :view_num

  belongs_to :user
end

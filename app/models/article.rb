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

  # ++++++++++++++++++++
  # query api
  # ++++++++++++++++++++

end

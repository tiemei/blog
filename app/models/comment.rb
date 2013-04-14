# encoding: UTF-8
class Comment < ActiveRecord::Base
  attr_accessible :cotent
  
  # ++++++++++++++++++++
  # validation
  # ++++++++++++++++++++
  validates :content, :presence => true
  validates :content, :length => { :in => 15..255 , 
                                   :message => '评论内容应该在25和255之间' }



  # ++++++++++++++++++++
  # association
  # ++++++++++++++++++++

  belongs_to :user
  belongs_to :article

  # ++++++++++++++++++++
  # query api
  # ++++++++++++++++++++


end

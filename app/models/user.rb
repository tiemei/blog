# encoding: UTF-8
class User < ActiveRecord::Base
  attr_accessible :about, :email, :name, :pwd

  # ++++++++++++++++++++
  # validation
  # ++++++++++++++++++++

  # 验证两次输入的密码一致 
  #validates :pwd, :confirmation => true 
  #validates :pwd_confirmation, :presence => true

  # 验证格式
  validates :name, :format => { :with    => /^[0-9a-zA-Z_]*$/,
                                :message => "用户名只能包含数字字母划线"}
  validates :pwd, :format => { :with    => /^[0-9a-zA-Z_]*$/,
                               :message => "密码只能包含数字字母划线"}
  validates :email, :format => { :with    => /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
                                 :message => "请检查邮箱地址是否合法" }

  # 验证存在
  validates :name, :presence => true
  validates :email, :presence => true
  validates :pwd, :presence => true

  # 验证唯一性，应用层面，多个db conn还是会重复
  validates :name, :uniqueness => { :case_sensitive => false }
  validates :email, :uniqueness => true

  # ++++++++++++++++++++
  # TODO callback
  # ++++++++++++++++++++

  # ++++++++++++++++++++
  # association
  # ++++++++++++++++++++

  has_many :articles, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all

  # 1. has_many asso obj 自动save，如果parent obj还没有
  # save，asso obj也不会自动save，制动调用了parent obj
  # 的save method  
  # 2. collection.build的asso objs 不会自动save
  # ++++++++++++++++++++
  # TODO query api
  # ++++++++++++++++++++

  def self.find_by_name(user)
    User.where("name = ?", user.name)
  end
end

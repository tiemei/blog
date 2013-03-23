class User < ActiveRecord::Base
  attr_accessible :about, :email, :name, :pwd

  has_many :articles, dependent: :delete_all
end

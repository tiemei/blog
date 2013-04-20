class Tag < ActiveRecord::Base
  attr_accessible :name

  # ++++++++++++++++++++
  # validation
  # ++++++++++++++++++++
  validates :name, :presence => true

  # ++++++++++++++++++++
  # association
  # ++++++++++++++++++++
  belongs_to :user
  belongs_to :article

  # ++++++++++++++++++++
  # query api
  # ++++++++++++++++++++
  # 返回某个用户某tag下对应文章个数
  def Tag.countAritlces(user_id, tag_name)
    Tag.where("user_id = #{user_id} and name = '#{tag_name}'").size
  end
  # return {"tagName1":2,"tagName2":3}
  def Tag.user_tag(user_id)
    result = {}
    User.find(user_id).tags.each do |tag|
      result[tag.name] ||= 0
      result[tag.name] = result[tag.name] + 1
    end
    result.sort do |a, b| # tag按count排序
      b[1] <=> a[1]
    end
  end
end

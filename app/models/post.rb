# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :text
#  author_id  :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :url, presence: true

  
  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User,
  inverse_of: :posts

  has_many :post_subs

  has_many :subs,
  through: :post_subs,
  source: :sub

end

# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text
#  mod_id      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :mod_id,
  class_name: :User,
  inverse_of: :subs


  has_many :post_subs

  has_many :posts,
  through: :post_subs,
  source: :post



  validates :moderator, presence: true
end

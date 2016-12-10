class PostSub < ActiveRecord::Base
  validates :post_id, :sub_id, presence:true
  validates :post_id, uniqueness: {scope: :sub_id}

  belongs_to :post,
  dependent: :destroy

  belongs_to :sub,
  dependent: :destroy
end

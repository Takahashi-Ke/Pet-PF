class Memory < ApplicationRecord
  
  # 作成日時が新しい順に取り出す
  default_scope -> {order(created_at: :desc)}
  belongs_to :pet
  has_many :memory_images, dependent: :destroy
  accepts_nested_attributes_for :memory_images, allow_destroy: true
  accepts_attachments_for :post_images, attachment: :images
  
  validates :title, presence: true
  validates :body, presence: true
  
end

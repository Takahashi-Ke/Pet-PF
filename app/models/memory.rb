class Memory < ApplicationRecord
  
  # 作成日時が新しい順に取り出す
  default_scope -> {order(created_at: :desc)}
  belongs_to :pet
  has_many :memory_images, dependent: :destroy
  has_many :memory_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  accepts_nested_attributes_for :memory_images, allow_destroy: true
  accepts_attachments_for :post_images, attachment: :images
  
  validates :title, presence: true
  validates :body, presence: true
  
  def memory_favorited_by?(pet, memory)
    Favorite.where(pet_id: pet.id, memory_id: memory.id).exists?
  end
  
end

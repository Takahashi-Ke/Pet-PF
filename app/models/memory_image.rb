class MemoryImage < ApplicationRecord
  
  belongs_to :memory
  
  attachment :image
  validates :image, presence: { message: 'は１枚以上選択してください' }
  
end

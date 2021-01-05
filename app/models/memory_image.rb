class MemoryImage < ApplicationRecord
  
  belongs_to :memory
  
  attachment :image
  validates :image, presence: true
  
end

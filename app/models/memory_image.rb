class MemoryImage < ApplicationRecord
  
  belongs_to :memory
  
  attachment :image
  
end

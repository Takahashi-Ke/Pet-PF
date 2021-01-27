class MemoryComment < ApplicationRecord
  belongs_to :pet
  belongs_to :memory

  validates :comment, presence: true
end

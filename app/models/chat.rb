class Chat < ApplicationRecord
  belongs_to :pet
  belongs_to :room

  validates :message, presence: :ture
end

class DiaryComment < ApplicationRecord
  belongs_to :pet
  belongs_to :diary
  has_many :notifications

  validates :comment, presence: true
end

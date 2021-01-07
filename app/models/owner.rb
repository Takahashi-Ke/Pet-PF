class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :pet, dependent: :destroy
  accepts_nested_attributes_for :pet, allow_destroy: true

  attachment :image
  
  validates :name, presence: true, length: { maximum: 10 }
end

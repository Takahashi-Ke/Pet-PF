class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :pet, dependent: :destroy
  accepts_nested_attributes_for :pet, allow_destroy: true

  attachment :image

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |owner|
      owner.password = SecureRandom.urlsafe_base64
      owner.name = 'ゲスト'
      owner.pet = Pet.new(
        id: owner.id,
        name: 'ゲストペット',
        birthday: '20180915',
        gender: 1,
        type: 3,
        introduction: "閲覧用アカウントです\r\n性格以外の編集と退会はできません"
      )
    end
  end
end

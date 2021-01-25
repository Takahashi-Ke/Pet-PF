class Pet < ApplicationRecord

  belongs_to :owner
  has_many :pet_personalities, dependent: :destroy
  accepts_nested_attributes_for :pet_personalities, allow_destroy: true
  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :memory_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :pet_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :favo_diaries, through: :favorites, source: :diary
  has_many :favo_memories, through: :favorites, source: :memory

  attachment :image

  validates :name, presence: true, length: { maximum: 10 }
  validates :introduction, length: { maximum: 120 }
  validate :after_tomorrow

  def after_tomorrow
    errors.add(:birthday, 'は今日より前で設定してください') if birthday > Date.today
  end

  self.inheritance_column = :_type_disabledrails

  enum gender: {
    オス: 1,
    メス: 2
  }
  enum type: {
    犬: 1,
    猫: 2,
    小動物: 3,
    鳥: 4,
    爬虫類: 5,
    魚: 6
  }

    # フォローするユーザ
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  # 自分がフォローしているユーザ
  has_many :followed_pets, through: :active_relationships,
                            source: :followed
  # フォローされるユーザ
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  # 自分をフォローしているユーザ
  has_many :following_pets, through: :passive_relationships,
                             source: :follower

  # 自分からの通知
  has_many :active_notifications, class_name: "Notification",
                                  foreign_key: "visitor_id",
                                  dependent: :destroy

  # 相手からの通知
  has_many :passive_notifications, class_name: "Notification",
                                  foreign_key: "visited_id",
                                  dependent: :destroy


  def follow(pet_id)
    active_relationships.create(followed_id: pet_id)
  end

  def unfollow(pet_id)
    active_relationships.find_by(followed_id: pet_id).destroy
  end

  def following?(pet)
    followed_pets.include?(pet)
  end

  # フォローされた時通知を生成するメソッド
  def create_notification_follow(pet)
    history = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",pet.id, id, 'follow'])
    if history.blank?
      notification = pet.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  scope :search, -> (search_params) do
    if search_params[:personalities].present?
      pet_personalities = PetPersonality.where(personality: search_params[:personalities])
      pet_ids = []
      pet_personalities.each do |pp|
        pet_ids << pp.pet_id
      end
    end
    keyword_search(search_params[:keyword])
      .type_search(search_params[:types])
      .gender_search(search_params[:genders])
      .personality_search(pet_ids)
  end
  
  scope :keyword_search, -> (keyword) { where("name LIKE?", "%#{keyword}%") unless keyword.blank? }
  scope :type_search, -> (types) { where(type: types) if types.present? }
  scope :gender_search, -> (genders) { where(gender: genders) if genders.present? }
  scope :personality_search, -> (pet_ids) { where(id: pet_ids) if pet_ids != [] }

  # ペットの年齢を算出するメソッド
  def age
    d1 = self.birthday.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
  end
  def moon_age
    d1 = self.birthday.strftime("%m").to_i
    d2 = Date.today.strftime("%m").to_i
    m = (d2 - d1) / 100
    if m < 0
      return m + 12
    else
      return m
    end
  end
  
  # 新しい通知を取得するメソッド
  def unchecked_notifications(pet)
    Notification.where(visited_id: id, is_checked: false)
  end
  # チャットの最新のメッセージを取得
  def latest_message(pet, current_pet)
    current_rooms = current_pet.pet_rooms.pluck(:room_id)
    room = pet.pet_rooms.find_by(room_id: current_rooms)
    latest_message = Chat.where(room_id: room.room_id).last
    return latest_message
  end


end

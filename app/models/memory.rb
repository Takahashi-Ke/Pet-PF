class Memory < ApplicationRecord
  
  # 作成日時が新しい順に取り出す
  default_scope -> {order(created_at: :desc)}
  belongs_to :pet
  has_many :memory_images, dependent: :destroy
  has_many :memory_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  accepts_attachments_for :memory_images, attachment: :image
  
  validates :title, presence: true
  validates :body, presence: true
  
  # 投稿にいいねしているかを確認
  def memory_favorited_by?(pet, memory)
    Favorite.where(pet_id: pet.id, memory_id: memory.id).exists?
  end
  
  # いいねされた時通知を生成するメソッド
  def create_notification_favo(pet)
    history = Notification.where(["visitor_id = ? and visited_id = ? and memory_id = ? and action = ?",
                                pet.id, pet_id, id, 'favorite'])
    if history.blank?
      notification = pet.active_notifications.new(
        memory_id: id,
        visited_id: pet_id,
        action: 'favorite'
        )
      # 自分で自分の日記にいいねした場合
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end

  # 投稿にコメントされた時通知を生成するメソッド
  def create_notification_comment(pet, memory_comment_id)
    history_ids = MemoryComment.select(:pet_id).where(memory_id: self.id).where.not(pet_id: pet.id).distinct
    # 自分意外にもコメントしている人がいる場合、その全員に通知を送る
    if history_ids.blank?
      save_notification_comment(pet, memory_comment_id, pet_id)
    else
      history_ids.each do |history_id|
        save_notification_comment(pet, memory_comment_id, history_id['pet_id'])
      end
    end
  end
  def save_notification_comment(pet, memory_comment_id, visited_id)
    notification = pet.active_notifications.new(
      memory_id: id,
      memory_comment_id: memory_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分で自分の投稿にコメントした場合
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    if notification.valid?
      notification.save
    end
  end
  
end

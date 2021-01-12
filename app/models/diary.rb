class Diary < ApplicationRecord

  
  belongs_to :pet
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :image

  validates :body, presence: true

  # 投稿にいいねしているかを確認
  def diary_favorited_by?(pet, diary)
      Favorite.where(pet_id: pet.id, diary_id: diary.id).exists?
  end
  # いいねされた時通知を生成するメソッド
  def create_notification_favo(pet)
    history = Notification.where(["visitor_id = ? and visited_id = ? and diary_id = ? and action = ?",
                                pet.id, pet_id, id, 'favorite'])
    if history.blank?
      notification = pet.active_notifications.new(
        diary_id: id,
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
  def create_notification_comment(pet, diary_comment_id)
    history_ids = DiaryComment.select(:pet_id).where(diary_id: self.id).where.not(pet_id: pet.id).distinct
    # 自分意外にもコメントしている人がいる場合、その全員に通知を送る
    if history_ids.blank?
      save_notification_comment(pet, diary_comment_id, pet_id)
    else
      history_ids.each do |history_id|
        save_notification_comment(pet, diary_comment_id, history_id['pet_id'])
      end
    end
  end
  def save_notification_comment(pet, diary_comment_id, visited_id)
    notification = pet.active_notifications.new(
      diary_id: id,
      diary_comment_id: diary_comment_id,
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

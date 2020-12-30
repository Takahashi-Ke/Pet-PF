class Notification < ApplicationRecord

  # 作成日時が新しい順に取り出す
  default_scope -> {order(created_at: :desc)}
  
  belongs_to :diary, optional: true
  belongs_to :diary_comment, optional: true
  belongs_to :visitor, class_name: 'Pet', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Pet', foreign_key: 'visited_id', optional: true

end
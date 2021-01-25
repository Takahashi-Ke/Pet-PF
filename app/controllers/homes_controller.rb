class HomesController < ApplicationController
  
  def top
    # 1週間分の画像データをランダムで１０個取得する
    to = Time.current.at_end_of_day
    from = (Time.current - 6.day).at_end_of_day
    # @random_photos = Diary.where.not(image_id: nil).where(created_at: from...to).order("RANDOM()").limit(10)
    # mySQL対応(RAND)
    @random_photos = Diary.where.not(image_id: nil).where(created_at: from...to).order("RAND()").limit(10)
    @diaries= Diary.includes(:diary_comments).where(created_at: Date.today.all_day).reverse_order
    #フォロワーランキング
    follow_count_id_hash = Relationship.group(:followed_id).order('count_followed_id DESC').limit(5).count(:followed_id)
    follow_count_id = follow_count_id_hash.keys
    #フォロワー順にユーザーを取得する
    @pets = Pet.where(id: follow_count_id).limit(10)
  end
  
end

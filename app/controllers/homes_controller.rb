class HomesController < ApplicationController
  
  def top
    # photos = .where(created_at: 1.week.ago.all_day)
    @random_photos = Diary.where.not(image_id: nil).order("RANDOM()").limit(10)
    @diaries = Diary.where(created_at: Date.today.all_day)
    @pets = Pet.all
    
    
  end
  
end

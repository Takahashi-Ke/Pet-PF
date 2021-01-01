class SearchesController < ApplicationController
  
  def search
    if params[:keyword].present?
      @keyword = params[:keyword]
      @pets = Pet.where("name LIKE?", "%#{@keyword}%")
              # .joins(:pet_personalities).where(personality: @personalities)
      @memories = Memory.where("title LIKE? OR body LIKE?", "%#{@keyword}%", "%#{@keyword}%")
      @diaries = Diary.where("body LIKE?", "%#{@keyword}%")
    end
    if params[:types]
      params[:types].each do |t|
        @types = Pet.select(:type).where(type: t)
      end
    end
    if params[:genders]
      params[:genders].each do |g|
        @genders = Pet.select(:gender).where(gender: g)
      end
    end
    if params[:personalities]
      params[:personalities].each do |pe|
        @personalities = PetPersonality.where(personality: pe)
      end
    end
    
    @diary = Diary.new
  end
  
end

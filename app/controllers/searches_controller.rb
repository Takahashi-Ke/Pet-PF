class SearchesController < ApplicationController
  
  def search
    # binding.pry
    if params[:keyword].present?
      @keyword = params[:keyword]
    end
    @pets = Pet.where("name LIKE?", "%#{@keyword}%").where.not(id: current_owner.pet) if params[:keyword].present?
              # .where(gender: params[:genders])if params[:genders].present?
            # .where(type: params[:types])if params[:types].present?
            # .joins(:pet_personalities).where(personality: @personalities)
    @memories = Memory.where("title LIKE? OR body LIKE?", "%#{@keyword}%", "%#{@keyword}%") if params[:keyword].present?
                      # .where(pet_id: @pet.ids) if @pet.present?
    @diaries = Diary.where("body LIKE?", "%#{@keyword}%")
                    # .where(pet_id: @pet)
    if params[:types].present?
      @types = params[:types]
    end
      
    if params[:genders].present?
      @genders = params[:genders]
    end
    if params[:personalities].present?
      @personalities = params[:personalities]
    end
    
    @diary = Diary.new
  end
  
end

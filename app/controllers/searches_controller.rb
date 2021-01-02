class SearchesController < ApplicationController
  
  def search
    # binding.pry
    
    if params[:keyword].present?
      @keyword = params[:keyword]
    end
    @pets = Pet.where("name LIKE?", "%#{@keyword}%").where.not(id: current_owner.pet) if params[:keyword].present?
              # .where(type: params[:types])if params[:types].present?
              # .where(gender: params[:genders])if params[:genders].present?
            # .joins(:pet_personalities).where(personality: @personalities)
    @memories = Memory.where("title LIKE? OR body LIKE?", "%#{@keyword}%", "%#{@keyword}%") if params[:keyword].present?
                      # .where(pet_id: @pet.ids) if @pet.present?
    @diaries = Diary.where("body LIKE?", "%#{@keyword}%")
                    # .where(pet_id: @pet)
    
    
    binding.pry
    
    if params[:types].present?
      params[:types].each do |t|
        @types = Pet.select(:type).where(type: t)
      end
    end
    if params[:genders].present?
      params[:genders].each do |g|
        @genders = Pet.select(:gender).where(gender: g)
      end
    end
    if params[:personalities].present?
      params[:personalities].each do |pe|
        @personalities = PetPersonality.where(personality: pe)
      end
    end
    
    @diary = Diary.new
  end
  
end

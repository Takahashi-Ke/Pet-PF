class SearchesController < ApplicationController
  
  def search
    # binding.pry
    if params[:keyword].blank?
      @keyword = params[:keyword]
    end
    if params[:types].present?
      @types = params[:types]
    end
    if params[:genders].present?
      @genders = params[:genders]
    end
    if params[:personalities].present?
      @personalities = params[:personalities]
    end
    @search_params = pet_search_params
    @pets = Pet.search(@search_params)
    # @pets = Pet.where("name LIKE?", "%#{@keyword}%").where.not(id: current_owner.pet) if params[:keyword].present?
    #         .where(gender: params[:genders])if params[:genders].present?
    #         .where(type: params[:types])if params[:types].present?
            # .joins(:pet_personalities).where(personality: @personalities)
    @memories = Memory.where("title LIKE? OR body LIKE?", "%#{@keyword}%", "%#{@keyword}%") if params[:keyword].present?
                      # .where(pet_id: @pet.ids) if @pet.present?
    @diaries = Diary.where("body LIKE?", "%#{@keyword}%")
                    # .where(pet_id: @pet)
    
    @diary = Diary.new
  end
  
  private
  def pet_search_params
    params.fetch(:search, {}).permit(:keyword, :types, :genders)
  end
  
end

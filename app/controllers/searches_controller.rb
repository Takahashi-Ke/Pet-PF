class SearchesController < ApplicationController
  
  def search
    @search_params = pet_search_params
    @pets = Pet.search(@search_params)
    unless @search_params[:keyword].blank?
      @memories = Memory.where("title LIKE? OR body LIKE?", "%#{@search_params[:keyword]}%", "%#{@search_params[:keyword]}%")
      @diaries = Diary.where("body LIKE?", "%#{@search_params[:keyword]}%")
    end
    # @memories << @pets.memories
    # diaries = []
    # @pets.each do |pet|
    #   diaries << pet.diaries
    # end
    
    # @diaries = diaries
    # binding.pry
    
    @diary = Diary.new
  end
  
  private
  def pet_search_params
    params.fetch(:search, {}).permit(:keyword, types: [], genders: [], personalities: [])
  end
  
end

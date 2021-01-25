class SearchesController < ApplicationController
  
  def search
    @search_params = pet_search_params
    unless  @search_params[:keyword].blank? &&
            @search_params[:types].nil? &&
            @search_params[:genders].nil? &&
            @search_params[:personalities].nil?
      @pets = Pet.search(@search_params)
    else
      redirect_to request.referer
    end
   
    unless @search_params[:keyword].blank?
      @memories = Memory.where("title LIKE? OR body LIKE?", "%#{@search_params[:keyword]}%", "%#{@search_params[:keyword]}%")
      @diaries = Diary.where("body LIKE?", "%#{@search_params[:keyword]}%").reverse_order
    end
    
    @diary = Diary.new
  end
  
  private
  def pet_search_params
    params.fetch(:search, {}).permit(:keyword, types: [], genders: [], personalities: [])
  end
  
end

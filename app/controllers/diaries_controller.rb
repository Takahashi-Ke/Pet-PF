class DiariesController < ApplicationController

  def index
    @pet = current_owner.pet
    @diary = Diary.new
    @diaries = Diary.page(params[:page]).per(4).reverse_order
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.pet = Pet.find(params[:pet_id])
    if @diary.save
      redirect_to request.referer
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to request.referer
  end

  private
  def diary_params
    params.require(:diary).permit(:body, :image)
  end

end

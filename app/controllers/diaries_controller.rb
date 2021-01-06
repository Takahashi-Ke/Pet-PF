class DiariesController < ApplicationController

  def index
    @pet = current_owner.pet
    @diary = Diary.new
    @diaries = Diary.all
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.pet = Pet.find(params[:pet_id])
    if @diary.save
      redirect_to request.referer
    else
      @pet = @diary.pet
      @personalities = @pet.pet_personalities
      @diaries = @pet.diaries
      @photos  = Diary.where.not(image_id: nil)
      @diary_comment = DiaryComment.new
      render 'pets/show'
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

class DiariesController < ApplicationController

  def index
    @pet = current_owner.pet
    @diary = Diary.new
    @diaries = Diary.all.reverse_order
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.pet = Pet.find(params[:pet_id])
    if @diary.invalid?
      flash.now[:alert] = "文章を入力してください"
      @pet = current_owner.pet
      @diary = Diary.new
      @diaries = Diary.all.reverse_order
      render 'index'
    elsif params[:diary][:image] != "{}"
      # visionAPIで画像認識
      post_image = params[:diary][:image]
      result = Vision.image_analysis(post_image)
    else
      result = true
    end
    if result == true
      @diary.save
      redirect_to request.referer
    elsif result == false
      flash.now[:alert] = "選択された画像が不適切なコンテンツと判断されました"
      @pet = current_owner.pet
      @diary = Diary.new
      @diaries = Diary.all.reverse_order
      render 'index'
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

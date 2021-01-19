class DiariesController < ApplicationController

  def index
    @pet = current_owner.pet
    @diary = Diary.new
    @diaries = Diary.all.reverse_order
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.pet = Pet.find(params[:pet_id])
    if params[:diary][:image]
      post_image = params[:diary][:image]
      # diary_image = File.open(params[:diary][:image].tempfile)
      result = Vision.image_analysis(post_image)
    else
      result = true
    end
    if result == true
      @diary.save
      redirect_to request.referer
    elsif result == false
      flash.now[:notice] = "選択された画像が不適切なコンテンツと判断されました"
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

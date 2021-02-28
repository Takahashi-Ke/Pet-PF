class DiariesController < ApplicationController
  def index
    @pet = current_owner.pet
    @diary = Diary.new
    @diaries = Diary.includes(:diary_comments).page(params[:page]).per(5).reverse_order
  end
  
  def show
    @diary = Diary.includes(:diary_comments).find(params[:id])
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.pet = Pet.find(params[:pet_id])
    if params[:diary][:image] != '{}' && params[:diary][:image].present?
      # visionAPIで画像認識
      post_image = params[:diary][:image]
      result = Vision.image_analysis(post_image)
    else
      result = true
    end
    if result == true && @diary.valid?
      @diary.save
      redirect_to diaries_path
    else
      if result == false
        flash.now[:alert] = '選択された画像が不適切なコンテンツと判断されました'
      elsif @diary.invalid?
        flash.now[:alert] = '文章を入力してください'
      end
      @pet = current_owner.pet
      @diary = Diary.new
      @diaries = Diary.all.reverse_order
      render 'index'
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:body, :image)
  end
end

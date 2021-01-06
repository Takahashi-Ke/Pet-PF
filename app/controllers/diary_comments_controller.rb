class DiaryCommentsController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id])
    @diary_comment = DiaryComment.new(comment_params)
    @diary_comment.pet_id = params[:pet_id]
    @diary_comment.diary_id = params[:diary_id]
    if @diary_comment.save
      @diary.create_notification_comment(current_owner.pet, @diary_comment.id)
    else
      @pet = Pet.find_by(id: current_owner.pet)
      @personalities = @pet.pet_personalities
      @diaries = @pet.diaries
      @photos  = Diary.where.not(image_id: nil)
      render 'pets/show'
    end
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @diary_comment = DiaryComment.find(params[:id])
    @diary_comment.destroy
  end

  private
  def comment_params
    params.require(:diary_comment).permit(:comment)
  end

end

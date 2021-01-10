class MemoryCommentsController < ApplicationController
  
  def create
    @memory = Memory.find(params[:memory_id])
    @memory_comment = MemoryComment.new(memory_params)
    @memory_comment.memory_id = @memory.id
    @memory_comment.pet_id = current_owner.pet.id
    if @memory_comment.save
      @memory.create_notification_comment(current_owner.pet, @memory_comment.id)
      @memory_comment = MemoryComment.new
    else
      @memory.memory_images.build
      @memories = current_owner.pet.memories
      @pet = current_owner.pet
      @diary = Diary.new
    end
  end
  
  def destroy
    @memory = Memory.find(params[:memory_id])
    @memory_comment = MemoryComment.find(params[:id])
    @memory_comment.destroy
    @memory_comment = MemoryComment.new
  end

  private
  def memory_params
    params.require(:memory_comment).permit(:comment)
  end
  
end

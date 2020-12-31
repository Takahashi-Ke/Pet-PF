class MemoryCommentsController < ApplicationController
  
  def create
    @memory = Memory.find(params[:memory_id])
    @memory_comment = MemoryComment.new(memory_params)
    @memory_comment.memory_id = @memory.id
    @memory_comment.pet_id = current_owner.pet.id
    @memory_comment.save
  end
  
  def destroy
    @memory = Memory.find(params[:memory_id])
    @memory_comment = MemoryComment.find(params[:id])
    @memory_comment.destroy
  end

  private
  def memory_params
    params.require(:memory_comment).permit(:comment)
  end
  
end

class MemoriesController < ApplicationController
  
  def new
    @memory = Memory.new
    @memory.memory_images.build
    @pet = current_owner.pet
    @diary = Diary.new
  end
  
  def create
    # binding.pry
    memory = Memory.new(memory_params)
    memory.pet_id = current_owner.pet.id
    memory.save
    redirect_to memory_path(memory)
  end
  
  def index
    @pet = current_owner.pet
    if params.has_key?(:pet_id)
      @posted_by_pet = Pet.find(params[:pet_id])
      @memories = Memory.where(pet_id: @pet.id).page(params[:page])
    else
      @memories = Memory.page(params[:page])
    end
    @diary = Diary.new
  end
  
  def show
    @memory = Memory.find(params[:id])
    @images = MemoryImage.where(memory_id: @memory.id)
    @pet = Pet.find_by(id: @memory.pet_id)
    @diary = Diary.new
    @memory_comment = MemoryComment.new
  end
  
  def edit
    @memory = Memory.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  def memory_params
    params.require(:memory).permit(:title, :body,
                                    memory_images_attributes: [:id, :image, :_destroy])
  end
  
end

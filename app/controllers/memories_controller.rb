class MemoriesController < ApplicationController
  
  def new
    @memory = Memory.new
    @memory.memory_images.build
    @pet = current_owner.pet
    @diary = Diary.new
  end
  
  def create
    binding.pry
    memory = Memory.new(memory_params)
    memory.save
  end
  
  def index
    @memories = Memory.all
    @diary = Diary.new
  end
  
  def show
    @memory = Memory.find(params[:id])
    @pet = Pet.find_by(id: @memory.pet_id)
    @diary = Diary.new
    
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

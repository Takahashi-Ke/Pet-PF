class MemoriesController < ApplicationController
  
  def new
    @memory = Memory.new
    @memory.memory_images.build
    @memories = current_owner.pet.memories
    @pet = current_owner.pet
    @diary = Diary.new
  end
  
  def create
    # binding.pry
    @memory = Memory.new(memory_params)
    @memory.pet_id = current_owner.pet.id
    if @memory.save
      redirect_to memory_path(@memory)
    else
      @memories = current_owner.pet.memories
      @memory.memory_images.build
      @pet = current_owner.pet
      @diary = Diary.new
      render :new
    end
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
    @memories = Memory.where(pet_id: @memory.pet_id)
    @images = MemoryImage.where(memory_id: @memory.id)
    @pet = current_owner.pet
    @diary = Diary.new
    @memory_comment = MemoryComment.new
  end
  
  def edit
    @memories = current_owner.pet.memories
    @memory = Memory.find(params[:id])
    @diary = Diary.new
  end
  
  def update
    memory = Memory.find(params[:id])
    memory.update(memory_params)
    redirect_to memory_path(memory)
  end
  
  def destroy
    memory = Memory.find(params[:id])
    memory.destroy
    redirect_to memories_path
  end
  
  private
  def memory_params
    params.require(:memory).permit(:title, :body, memory_images_images: [])
  end
  
end

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
    if @memory.invalid?
      render_new
    else
      # visionAPIで画像認識
      params[:memory][:memory_images_images].each do |post_image|
        next if post_image == '[]'
        result = Vision.image_analysis(post_image)
        next if result == true
        flash.now[:alert] = '選択された画像が不適切なコンテンツと判断されました'
        return render_new
      end
      @memory.save
      redirect_to memory_path(@memory)
    end
  end

  def index
    @pet = current_owner.pet
    if params.has_key?(:pet_id)
      @posted_by_pet = Pet.find(params[:pet_id])
      @memories = Memory.includes(:memory_images, :memory_comments).where(pet_id: @pet.id).page(params[:page])
    else
      @memories = Memory.includes(:memory_images, :memory_comments).page(params[:page])
    end
    @diary = Diary.new
  end

  def show
    @memory = Memory.includes(:memory_images, :memory_comments).find(params[:id])
    @memories = Memory.where(pet_id: @memory.pet_id)
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
    @memory = Memory.find(params[:id])
    params[:memory][:memory_images_images].each do |post_image|
      next if post_image == '[]'
      result = Vision.image_analysis(post_image)
      next if result == true
      flash.now[:alert] = '選択された画像が不適切なコンテンツと判断されました'
      return render_edit
    end
    if @memory.update(memory_params)
      redirect_to memory_path(@memory)
    else
       render_edit
    end
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
  def render_new
    @memories = current_owner.pet.memories
    @memory.memory_images.build
    @pet = current_owner.pet
    @diary = Diary.new
    render :new
  end
  def render_edit
    @memories = current_owner.pet.memories
    @diary = Diary.new
    render :edit
  end
  
end

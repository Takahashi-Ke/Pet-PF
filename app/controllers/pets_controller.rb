class PetsController < ApplicationController
  before_action :check_guest, only: :update

  def show
    @pet = Pet.find(params[:id])
    @pet_personalities = @pet.pet_personalities
    @pet.pet_personalities.build
    @memories = @pet.memories
    @diaries = @pet.diaries.reverse_order
    @photos  = Diary.where.not(image_id: nil).where(pet_id: @pet).reverse_order
    @diary = Diary.new
    @diary_comment = DiaryComment.new
  end

  def edit
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.pet_personalities.destroy_all
    if params[:owner][:pet_attributes][:pet_personalities].present?
      params[:owner][:pet_attributes][:pet_personalities].each do |pp|
        PetPersonality.personalities.map do |_k, v|
          next unless v == pp.to_i

          pet_personality = @pet.pet_personalities.new(personality_params)
          pet_personality.personality = pp.to_i
          pet_personality.save
        end
      end
    end
    if current_owner.update(owner_pet_params)
      redirect_to pet_path(@pet)
    else
      @owner = @pet.owner
      render :edit
    end
  end

  private

  def owner_pet_params
    params.require(:owner).permit(:name, :image,
                                  pet_attributes: %i[id name image birthday gender type introduction _destroy])
  end

  def personality_params
    params.permit(:personality)
  end

  # ゲストの場合は編集を制限
  def check_guest
    if current_owner.email == 'guest@example.com'
      params[:owner][:image] = nil
      params[:owner][:name] = 'ゲスト'
      params[:owner][:pet_attributes][:image] = nil
      params[:owner][:pet_attributes][:introduction] = "閲覧用アカウントです\r\n性格以外の編集と退会はできません"
      params[:owner][:pet_attributes][:name] = 'ゲストペット'
    end
  end
end

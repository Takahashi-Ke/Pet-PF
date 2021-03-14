require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  # フォローするユーザ
  let!(:follower_owner) { create(:owner) }
  let!(:follower_pet) { create(:pet, owner_id: follower_owner.id) }
  # フォローされるユーザ
  let!(:followed_owner) { create(:owner) }
  let!(:followed_pet) { create(:pet, owner_id: followed_owner.id) }
  
  
  describe "フォロー処理(POST #create)" do
    context "ログイン済みの場合" do
      before do
        sign_in follower_owner
        get pet_path(followed_pet)
      end
      it "ユーザをフォローできるか" do
        post pet_relationships_path(pet_id: followed_pet.id), xhr: true
        expect(Relationship.find_by(followed_id: followed_pet.id, follower_id: follower_pet.id)).to be_truthy
      end
    end
  end
  
  describe "フォロー解除処理(DELETE #destroy)" do
    context "ログイン済みの場合" do
      before do
        sign_in follower_owner
        get pet_path(followed_pet)
        post pet_relationships_path(pet_id: followed_pet.id), xhr: true
      end
      it "ユーザのフォローを解除できるか" do
        delete pet_relationship_path(id: followed_pet.id), xhr: true
        expect(Relationship.find_by(followed_id: followed_pet.id, follower_id: follower_pet.id)).to be_falsey
      end
    end
  end
  
end
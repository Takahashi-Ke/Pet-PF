require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet, owner_id: owner.id) }
  let!(:diary) { create(:diary, pet_id: pet.id, body: "テスト日記") }
  
  describe "一覧画面の表示(GET #index)" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get favorites_path
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get favorites_path
      expect(response).to have_http_status(200)
      end
    end
    
  end
  
  describe "いいね処理(POST #create)" do 
    context "ログイン済みの場合" do
      before do
        sign_in owner
        get diary_path(diary)
      end
      it "投稿をいいねできるか" do
        post favorites_path(id: diary.id), xhr: true
        expect(Favorite.find_by(pet_id: pet.id, diary_id: diary.id)).to be_truthy
      end
    end
  end
  
  describe "いいね解除処理(DELETE #destroy)" do 
    context "ログイン済みの場合" do
      before do
        sign_in owner
        get diary_path(diary)
        post favorites_path(id: diary.id), xhr: true
      end
      it "投稿のいいねを解除できるか" do
        delete favorite_path(id: diary.id), xhr: true
        expect(Favorite.find_by(pet_id: pet.id, diary_id: diary.id)).to be_falsey
      end
    end
  end
  
end
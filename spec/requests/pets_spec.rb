require 'rails_helper'

RSpec.describe "Pet", type: :request do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet, owner_id: owner.id) }
  
  describe "マイページ画面の表示(GET #show)" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get pet_path(pet)
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get pet_path(pet)
      expect(response).to have_http_status(200)
      end
    end
    
  end
  
  describe "プロフィール編集画面の表示(GET #edit)" do
        
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get edit_pet_path(pet)
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get edit_pet_path(pet)
      expect(response).to have_http_status(200)
      end
    end
    
  end
  
  
end
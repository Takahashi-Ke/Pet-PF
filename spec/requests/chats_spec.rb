require 'rails_helper'

RSpec.describe "Chats", type: :request do
  # ログインしているユーザ
  let!(:owner_1) { create(:owner) }
  let!(:pet_1) { create(:pet, owner_id: owner_1.id) }
  # チャットあいて
  let!(:owner_2) { create(:owner) }
  let!(:pet_2) { create(:pet, owner_id: owner_2.id) }
  # pet_1とpet_2のチャットルーム
  let!(:room) { create(:room) }
  
  describe "チャット画面の表示(GET #index)" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get pet_chats_path(pet_2)
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner_1
      end
      it "表示に成功すること" do
        get pet_chats_path(pet_2)
      expect(response).to have_http_status(200)
      end
    end
    
  end
  
  describe "チャット送信処理(POST #create)" do
    
    context "ログイン済みの場合" do
      before do
        sign_in owner_1
      end
      it "メッセージを送信できるか" do
        get pet_chats_path(pet_2)
        post pet_chats_path(pet_id: pet_1.id,room_id: room.id), params: { chat: { message: "チャットテスト" } }, xhr: true
        expect(Chat.find_by(pet_id: pet_1.id, message: "チャットテスト")).to be_truthy
      end
    end
    
  end
  
end
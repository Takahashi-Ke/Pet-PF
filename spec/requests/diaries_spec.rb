require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet, owner_id: owner.id) }
  let!(:diary) { create(:diary, pet_id: pet.id, body: "テスト日記") }
  
  describe "一覧画面の表示(GET #index)" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get diaries_path
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get diaries_path
      expect(response).to have_http_status(200)
      end
    end
    
  end
  
  describe "詳細画面の表示(GET #show)" do
     
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get diary_path(diary)
        expect(response).to redirect_to new_owner_session_path
      end
    end
      
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get diary_path(diary)
        expect(response).to have_http_status(200)
      end
    end
     
  end
  
  describe "投稿処理(POST #create)" do 
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "日記を投稿できるか" do
        get diaries_path
        post diaries_path(pet_id: pet.id), params: { diary: { body: "日記のテスト",image: nil } }
        expect(Diary.find_by(pet_id: pet.id, body: "日記のテスト")).to be_truthy
      end
      it "投稿後、一覧画面に遷移するか" do
        post diaries_path(pet_id: pet.id), params: { diary: { body: "日記のテスト",image: nil } }
        expect(response).to redirect_to diaries_path
      end
    end
    
  end
  
  describe "消去処理(DELETE #destroy)" do
    
    context "自分の投稿の場合" do
      before do
        sign_in owner
        get diaries_path
      end
      it "日記を削除できるか" do
        delete diary_path(diary)
        expect(Diary.find_by(pet_id: pet.id, body: "テスト日記")).to be_falsey
      end
      it "削除後、一覧画面に遷移するか" do
        delete diary_path(diary)
        expect(response).to redirect_to diaries_path
      end
    end
    
  end
  
  
end
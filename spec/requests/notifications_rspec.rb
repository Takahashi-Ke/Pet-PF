require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet, owner_id: owner.id) }
  
  describe "一覧画面の表示(GET #index)" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get notifications_path
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get notifications_path
      expect(response).to have_http_status(200)
      end
    end
    
  end
    
end
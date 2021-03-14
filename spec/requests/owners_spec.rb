require 'rails_helper'

RSpec.describe "Owner", type: :request do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet, owner_id: owner.id) }
  
  describe "退会画面の表示(GET #unsubscribe)" do
    
    context "未ログインの場合" do
      it "ログインページへリダイレクトすること" do
        get unsubscribe_owner_path(owner)
        expect(response).to redirect_to new_owner_session_path
      end
    end
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get unsubscribe_owner_path(owner)
        expect(response).to have_http_status(200)
      end
    end
    
  end
    
  describe "退会処理(DELETE #destroy)" do
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
        get unsubscribe_owner_path(owner)
      end
      it "退会できるか" do
        delete owner_path(owner)
        expect(Owner.find_by(id: owner.id)).to be_falsey
      end
      it "退会後トップページに遷移するか" do
        delete owner_path(owner)
        expect(response).to redirect_to root_path
      end
    end
    
  end
  
end
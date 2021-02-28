require 'rails_helper'

RSpec.describe "Inquiries", type: :request do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet, owner_id: owner.id) }
  
  describe "新規お問い合わせ画面の表示(GET #new)" do  
    
    context "ログイン済みの場合" do
      before do
        sign_in owner
      end
      it "表示に成功すること" do
        get  inquiry_path
        expect(response).to have_http_status(200)
      end
    end
    
  end
  
  describe "お問い合わせ確認画面の表示(GET #new)" do  
    before do
      sign_in owner
      get  inquiry_path
    end
    
    context "入力に不備がない場合" do
      it "表示に成功すること" do
        get  inquiry_confirm_path, params: { inquiry: { name: "問合太郎", email: "test@test.com", message: "お問い合わせ" } }
        expect(response).to have_http_status(200)
      end
    end
    
    context "入力に不備がある場合" do
      it "新規お問い合わせ画面に戻ること" do
        get  inquiry_confirm_path, params: { inquiry: { name: nil, email: nil, message: nil } }
        expect(response).to render_template "new"
      end
    end
    
  end
  
  
  
end
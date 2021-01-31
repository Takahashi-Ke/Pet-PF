require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  before do
    @diary = create(:diary)
  end
  describe "GET #index" do
    it '日記一覧画面の表示に成功すること' do
      get diaries_path
      expect(response).to have_http_status(302)
    end
  end
  
  describe "DELETE #destroy" do
    it '日記削除後、前の画面にリダイレクトされるか' do
      delete diary_path(@diary)
      expect(response).to redirect_to diaries_path
      
    end
  end
  
  
end
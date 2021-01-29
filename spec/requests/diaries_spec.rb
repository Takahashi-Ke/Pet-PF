require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  
  describe "GET #index" do
    it '日記一覧画面の表示に成功すること' do
      get diaries_path
      expect(response).to have_http_status(302)
    end
  end
  
  
end
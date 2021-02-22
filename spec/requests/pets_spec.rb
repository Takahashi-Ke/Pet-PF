require 'rails_helper'

RSpec.describe Pet, type: :request do
  before do
    @pet = create(:pet)
  end
  
  describe "GET #show" do
    it 'マイページ画面の表示に成功すること' do
      get pet_path(@pet)
      expect(response).to have_http_status(302)
    end
  end
  describe "GET #edit" do
    it '編集画面の表示に成功すること' do
      get edit_pet_path(@pet)
      expect(response).to have_http_status(302)
    end
  end
  
  
end
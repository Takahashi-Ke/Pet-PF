require 'rails_helper'

RSpec.describe "Pets", type: :request do
  before do
    @pet = FactoryBot.create(:pet)
  end
  
  describe "GET #show" do
    it 'マイページ画面の表示に成功すること' do
      get pet_path(@pet)
      expect(response).to have_http_status(302)
    end
  end
  describe "GET #edit" do
    it 'リクエストが成功すること' do
      get edit_pet_path(@pet)
      expect(response.status).to have_http_status(200)
    end
  end
  # describe "GET #update" do
  #   it 'マイページ画面の表示に成功すること' do
  #     get pet_path(@pet)
  #     expect(response).to have_http_status(302)
  #   end
  # end
  
  
end
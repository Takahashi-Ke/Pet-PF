require 'rails_helper'

RSpec.describe "Memories", type: :request do
  before do
    @memory = create(:memory)
    
  end
  
  describe "GET #index" do
    it '思い出一覧画面の表示に成功すること' do
      get memories_path
      expect(response).to have_http_status(302)
    end
  end
  describe "GET #show" do
    it '思い出詳細画面の表示に成功すること' do
      get memory_path(@memory)
      expect(response).to have_http_status(302)
    end
  end
  describe "GET #edit" do
    it '思い出編集画面の表示に成功すること' do
      get edit_memory_path(@memory)
      expect(response).to have_http_status(302)
    end
  end
  
  # describe 'POST #create' do
  #   before do
  #     @owner = FactoryBot.create(:owner)
  #     @pet = FactoryBot.create(:pet)
  #   end
  #   context 'パラメータが正常な場合' do
  #     it 'リクエストが成功すること' do
  #       post memory_path, params: { pet: @pet,
  #                                   memory: FactoryBot.attributes_for(:memory),
  #                                   memory_image: FactoryBot.attributes_for(:memory_image) }
        
  #       expect(response.status).to  have_http_status(302)
  #     end

    #   it 'ユーザーが登録されること' do
    #     expect do
    #       post :create, params: { user: FactoryBot.attributes_for(:user) }
    #     end.to change(User, :count).by(1)
    #   end

    #   it 'リダイレクトすること' do
    #     post :create, params: { user: FactoryBot.attributes_for(:user) }
    #     expect(response).to redirect_to User.last
    #   end
    # end

    # context 'パラメータが不正な場合' do
    #   it 'リクエストが成功すること' do
    #     post :create, params: { user: FactoryBot.attributes_for(:user, :invalid) }
    #     expect(response.status).to eq 200
    #   end

    #   it 'ユーザーが登録されないこと' do
    #     expect do
    #       post :create, params: { user: FactoryBot.attributes_for(:user, :invalid) }
    #     end.to_not change(User, :count)
    #   end

    #   it 'newテンプレートで表示されること' do
    #     post :create, params: { user: FactoryBot.attributes_for(:user, :invalid) }
    #     expect(response).to render_template :new
    #   end

    #   it 'エラーが表示されること' do
    #     post :create, params: { user: FactoryBot.attributes_for(:user, :invalid) }
    #     expect(assigns(:user).errors.any?).to be_truthy
    #   end
    # end
  # end
  
end
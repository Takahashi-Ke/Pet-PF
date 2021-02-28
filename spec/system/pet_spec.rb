require 'rails_helper'

RSpec.describe "Pet", type: :system do
  let!(:owner) { attributes_for(:pet) }
  binding.pry
  describe 'オーナー、ペット情報編集テスト' do
    before do
      sign_in_as(owner)
      visit pet_path(owner.pet)
    end
    context '編集に成功、マイページに遷移' do
      it '正しく遷移されているか' do
        click_on '編集'
        visit edit_pet_path(ownet.pet)
        expect(page).to have_content 'プロフィール編集'
      end
      it '編集に成功する' do
        fill_in 'owner[name]', with: 'testowner'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][introduction]', with: Faker::Lorem.characters(number: 100)
        select 'おとなしい',from: 'owner[:pet_attributes][:pet_personalities]'
        
        click_button '更新する'
        expect(current_path).to eq pet_path(pet)
      end
    end
  end
end
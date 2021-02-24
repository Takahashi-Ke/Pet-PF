require 'rails_helper'

RSpec.describe "Owner", type: :system do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet) }
  describe 'ユーザー新規登録' do
    before do
      visit new_owner_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'owner[name]', with: owner.name
        fill_in 'owner[email]', with: owner.email
        fill_in 'owner[password]', with: owner.password
        fill_in 'owner[password_confirmation]', with: owner.password
        fill_in 'owner[pet_attributes][name]', with: pet.name
        # fill_in 'owner[pet_attributes][birthday]', with: pet.birthday
        # select 'owner[pet_attributes][gender]', selected: pet.gender
        choose 'owner_pet_attributes_gender_オス'
        select pet.type, from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq pet_path(pet)
      end
    end
  end
end
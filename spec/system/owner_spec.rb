require 'rails_helper'

RSpec.describe "Owner", type: :system do
  let!(:owner) { create(:owner) }
  let!(:pet) { create(:pet) }
  describe 'ユーザー新規登録テスト' do
    before do
      visit new_owner_registration_path
    end
    context '新規登録に成功、マイページに遷移' do
      it '新規登録に成功する' do
        fill_in 'owner[name]', with: 'testowner'
        fill_in 'owner[email]', with: 'test@test.com'
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '111111'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][birthday]', with: '2018-11-12'
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq pet_path(2)
      end
    end
    context '新規登録に失敗、エラーメッセージ表示' do
      it '名前未入力の場合、新規登録に失敗する' do
        fill_in 'owner[name]', with: ''
        fill_in 'owner[email]', with: 'test@test.com'
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '111111'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][birthday]', with: '2018-11-12'
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq owner_registration_path
        expect(page).to have_content "名前を入力してください"
      end
      it 'メールアドレス入力の場合、新規登録に失敗する' do
        fill_in 'owner[name]', with: 'testowner'
        fill_in 'owner[email]', with: ''
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '111111'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][birthday]', with: '2018-11-12'
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq owner_registration_path
        expect(page).to have_content "メールアドレスを入力してください"
      end
      it 'メールアドレスがすでに登録されているの場合、新規登録に失敗する' do
        fill_in 'owner[name]', with: ''
        fill_in 'owner[email]', with: owner.email
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '111111'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][birthday]', with: '2018-11-12'
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq owner_registration_path
        expect(page).to have_content "メールアドレスはすでに存在します"
      end
      it 'メッセージが一致しない場合、新規登録に失敗する' do
        fill_in 'owner[name]', with: 'testowner'
        fill_in 'owner[email]', with: 'test@test.com'
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '222222'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][birthday]', with: '2018-11-12'
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq owner_registration_path
        expect(page).to have_content "パスワードの入力が一致しません"
      end
      it 'ペットの情報が未入力の場合、新規登録に失敗する' do
        fill_in 'owner[name]', with: 'testowner'
        fill_in 'owner[email]', with: 'test@test.com'
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '111111'
        fill_in 'owner[pet_attributes][name]', with: ''
        fill_in 'owner[pet_attributes][birthday]', with: ''
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq owner_registration_path
        expect(page).to have_content "ペットの名前を入力してください"
        expect(page).to have_content "ペットの誕生日を入力してください"
      end
      it 'ペットの誕生日が未来の場合、新規登録に失敗する' do
        fill_in 'owner[name]', with: 'testowner'
        fill_in 'owner[email]', with: 'test@test.com'
        fill_in 'owner[password]', with: '111111'
        fill_in 'owner[password_confirmation]', with: '111111'
        fill_in 'owner[pet_attributes][name]', with: 'testpet'
        fill_in 'owner[pet_attributes][birthday]', with: '2030-05-01'
        choose 'owner_pet_attributes_gender_オス'
        select '犬', from: 'owner[pet_attributes][type]'
        
        click_button '新規登録'
        expect(current_path).to eq owner_registration_path
        expect(page).to have_content "ペットの誕生日を正しく設定してください"
      end
    end
  end
  describe 'ユーザーログインテスト' do
    before do
      visit new_owner_session_path
    end
    context 'ログインに成功、マイページに遷移' do
      it 'ログインに成功する' do
        fill_in 'owner[email]', with: owner.email
        fill_in 'owner[password]', with: owner.password
        
        click_button 'ログイン'
        expect(current_path).to eq pet_path(id: pet.id)
      end
    end
    context 'ログインに失敗、エラーメッセージを表示' do
      it 'メールアドレスが一致しない場合' do
        fill_in 'owner[email]', with: 'test@test.com'
        fill_in 'owner[password]', with: owner.password
        
        click_button 'ログイン'
        expect(current_path).to eq owner_session_path
        expect(page).to have_content "メールアドレス もしくはパスワードに誤りがあります"
      end
      it 'パスワードが一致しない場合' do
        fill_in 'owner[email]', with: owner.email
        fill_in 'owner[password]', with: '222222'
        
        click_button 'ログイン'
        expect(current_path).to eq owner_session_path
        expect(page).to have_content "メールアドレス もしくはパスワードに誤りがあります"
      end
    end
  end
end
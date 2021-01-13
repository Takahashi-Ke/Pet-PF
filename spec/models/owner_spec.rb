require 'rails_helper'

RSpec.describe Owner, type: :model do
  subject { owner.valid? }
  let!(:owner) { build(:owner) }
  
  describe '入力時バリデーションテスト' do
    
    context '空欄のとき' do
      it '名前が空だとエラーが返ってくるか' do
        owner.name = ''
        is_expected.to eq false
        expect(owner.errors[:name]).to include("を入力してください")
      end
    end
    context '空欄のとき' do
      it 'メールアドレスが空だとエラーが返ってくるか' do
        owner.email = ''
        is_expected.to eq false
        expect(owner.errors[:email]).to include("を入力してください")
      end
    end
    
    context '文字数制限' do
      it '名前が10文字以上だとエラーが返ってくるか' do
        owner.name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
        expect(owner.errors[:name]).to include("は10文字以内で入力してください")
      end
      it '名前が10文字以上だとエラーが返ってくるか' do
        owner.password = Faker::Number.number(digits: 5)
        is_expected.to eq false
        expect(owner.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
    
  end
  
  describe '関連付けテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    
    context 'Petモデルとの関係' do
      let(:target) { :pet }
      it '1:1の関係か' do
        expect(association.macro).to eq :has_one
      end
    end
  end
  
end
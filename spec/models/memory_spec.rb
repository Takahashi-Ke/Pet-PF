require 'rails_helper'

RSpec.describe Memory, type: :model do
  subject { memory.valid? }
  let!(:memory) { build(:memory) }
  
  describe '入力時バリデーションテスト' do
    
    context '空欄のとき' do
      it 'タイトルが空だとエラーが返ってくるか' do
        memory.title = ''
        is_expected.to eq false
        expect(memory.errors[:title]).to include("を入力してください")
      end
      it '文章が空だとエラーが返ってくるか' do
        memory.body = ''
        is_expected.to eq false
        expect(memory.errors[:body]).to include("を入力してください")
      end
    end
    
    context '文字数制限' do
      it 'タイトルが20文字以上だとエラーが返ってくるか' do
        memory.title = Faker::Lorem.characters(number: 25)
        is_expected.to eq false
        expect(memory.errors[:title]).to include("は20文字以内で入力してください")
      end
    end
    
  end
    
  describe '関連付けテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    
    context 'Petモデルとの関係' do
      let(:target) { :pet }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
    end
    
    context 'MemoryCommentモデルとの関係' do
      let(:target) { :memory_comments }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end
    
    context 'MemoryImageモデルとの関係' do
      let(:target) { :memory_images }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end
    
    context 'Favoriteモデルとの関係' do
      let(:target) { :favorites }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end
    
    context 'Notificationモデルとの関係' do
      let(:target) { :notifications }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end
    
  end
    
end
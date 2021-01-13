require 'rails_helper'

RSpec.describe Chat, type: :model do
  subject { chat.valid? }
  let!(:chat) { build(:chat) }
  
  describe '入力時バリデーションテスト' do
    context '空欄のとき' do
      it '送信できないようになっているか' do
        chat.message = ''
        is_expected.to eq false
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
    
    context 'Roomモデルとの関係' do
      let(:target) { :room }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
    end
    
    
  end
  
  
end
  
require 'rails_helper'

RSpec.describe Notification, type: :model do
  
    describe '関連付けテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    
    context 'Petモデル(visitor)との関係' do
      let(:target) { :visitor }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連付くモデルはPetモデルか' do
        expect(association.class_name).to eq 'Pet'
      end
    end
    
    context 'Petモデル(visited)との関係' do
      let(:target) { :visited }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連付くモデルはPetモデルか' do
        expect(association.class_name).to eq 'Pet'
      end
    end
    
    context 'Diaryモデルとの関係' do
      let(:target) { :diary }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
    end
    
    context 'Memoryモデルとの関係' do
      let(:target) { :memory }
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
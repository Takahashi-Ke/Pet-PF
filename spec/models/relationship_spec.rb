require 'rails_helper'

RSpec.describe Relationship, type: :model do
  
  describe '関連付けテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    
    context 'Petモデル(follower)との関係' do
      let(:target) { :follower }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連付くモデルはPetモデルか' do
        expect(association.class_name).to eq 'Pet'
      end
    end
    
    context 'Petモデル(followed)との関係' do
      let(:target) { :followed }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連付くモデルはPetモデルか' do
        expect(association.class_name).to eq 'Pet'
      end
    end

  end
  
end
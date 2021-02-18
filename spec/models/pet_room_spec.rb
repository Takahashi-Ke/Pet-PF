require 'rails_helper'

RSpec.describe PetRoom, type: :model do
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

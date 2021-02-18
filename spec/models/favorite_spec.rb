require 'rails_helper'

RSpec.describe Favorite, type: :model do
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
  end
end

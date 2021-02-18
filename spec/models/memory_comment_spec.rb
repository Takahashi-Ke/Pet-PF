require 'rails_helper'

RSpec.describe MemoryComment, type: :model do
  subject { memory_comment.valid? }
  let!(:memory_comment) { build(:memory_comment) }

  describe '入力時バリデーションテスト' do
    context '空欄のとき' do
      it '文章が空だとエラーが返ってくるか' do
        memory_comment.comment = ''
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

    context 'Memoryモデルとの関係' do
      let(:target) { :memory }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end

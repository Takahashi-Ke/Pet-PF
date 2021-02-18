require 'rails_helper'

RSpec.describe MemoryImage, type: :model do
  subject { memory_image.valid? }
  let!(:memory_image) { build(:memory_image) }

  describe '入力時バリデーションテスト' do
    context '空欄のとき' do
      it '画像が選択されなかった時エラーが返ってくるか' do
        memory_image.image = ''
        is_expected.to eq false
        expect(memory_image.errors[:image]).to include('は１枚以上選択してください')
      end
    end
  end

  describe '関連付けテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Memoryモデルとの関係' do
      let(:target) { :memory }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end

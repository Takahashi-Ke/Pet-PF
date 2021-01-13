require 'rails_helper'

RSpec.describe DiaryComment, type: :model do
  subject { diary_comment.valid? }
  let!(:diary_comment) { build(:diary_comment) }
  
  describe '入力時バリデーションテスト' do
    
    context '空欄のとき' do
      it '文章が空だとエラーが返ってくるか' do
        diary_comment.comment= ''
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
    
    context 'Diaryモデルとの関係' do
      let(:target) { :diary }
      it '1:Nの関係か' do
        expect(association.macro).to eq :belongs_to
      end
    end
    
  end
  
end
require 'rails_helper'

RSpec.describe Diary, type: :model do
  subject { diary.valid? }
  let!(:diary) { build(:diary) }

  describe '入力時バリデーションテスト' do
    context '空欄のとき' do
      it '文章が空だとエラーが返ってくるか' do
        diary.body = ''
        is_expected.to eq false
      end
    end

    context '文字数制限' do
      it '文章が120文字以上だとエラーが返ってくるか' do
        diary.body = Faker::Lorem.characters(number: 121)
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

    context 'DiaryCommentモデルとの関係' do
      let(:target) { :diary_comments }
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

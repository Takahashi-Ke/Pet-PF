require 'rails_helper'

RSpec.describe Pet, type: :model do
  subject { pet.valid? }
  let!(:pet) { build(:pet) }

  describe '入力時バリデーションテスト' do
    context '空欄のとき' do
      it '名前が空だとエラーが返ってくるか' do
        pet.name = ''
        is_expected.to eq false
        expect(pet.errors[:name]).to include('を入力してください')
      end
    end

    context '文字数制限' do
      it '名前が10文字以上だとエラーが返ってくるか' do
        pet.name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
        expect(pet.errors[:name]).to include('は10文字以内で入力してください')
      end
      it '紹介文が120文字以上だとエラーが返ってくるか' do
        pet.introduction = Faker::Lorem.characters(number: 121)
        is_expected.to eq false
        expect(pet.errors[:introduction]).to include('は120文字以内で入力してください')
      end
    end

    context '日付' do
      it '誕生日が次の日以降だとエラーが返ってくるか' do
        pet.birthday = Date.today + 1.day
        is_expected.to eq false
        expect(pet.errors[:birthday]).to include('を正しく設定してください')
      end
    end
  end

  describe '関連付けテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Ownerモデルとの関係' do
      let(:target) { :owner }
      it '1:1の関係か' do
        expect(association.macro).to eq :belongs_to
        expect(association.class_name).to eq 'Owner'
      end
    end

    context 'Diaryモデルとの関係' do
      let(:target) { :diaries }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Memoryモデルとの関係' do
      let(:target) { :memories }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'DiaryCommentモデルとの関係' do
      let(:target) { :diary_comments }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Memoryモデルとの関係' do
      let(:target) { :memories }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'MemoryCommentモデルとの関係' do
      let(:target) { :memory_comments }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'PetPersonalityモデルとの関係' do
      let(:target) { :pet_personalities }
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

    context 'Relationshipモデル(active_relationships)との関係' do
      let(:target) { :active_relationships }

      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
      it '関連するモデル名はRelationshipか' do
        expect(association.class_name).to eq 'Relationship'
      end
    end

    context 'Relationshipモデル(passive_relationships)との関係' do
      let(:target) { :active_relationships }

      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
      it '関連するモデル名はRelationshipか' do
        expect(association.class_name).to eq 'Relationship'
      end
    end

    context 'Chatモデルとの関係' do
      let(:target) { :chats }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'PetRoomモデルとの関係' do
      let(:target) { :pet_rooms }
      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Notificationモデル(active_notifications)との関係' do
      let(:target) { :active_notifications }

      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
      it '関連するモデル名はRelationshipか' do
        expect(association.class_name).to eq 'Notification'
      end
    end

    context 'Notificationモデル(passive_notifications)との関係' do
      let(:target) { :passive_notifications }

      it '1:Nの関係か' do
        expect(association.macro).to eq :has_many
      end
      it '関連するモデル名はRelationshipか' do
        expect(association.class_name).to eq 'Notification'
      end
    end
  end
end
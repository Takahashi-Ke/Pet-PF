require 'rails_helper'

RSpec.describe "DiaryComment", type: :request do
  # 投稿主のユーザ
  let!(:post_owner) { create(:owner) }
  let!(:post_pet) { create(:pet, owner_id: post_owner.id) }
  let!(:diary) { create(:diary, pet_id: post_pet.id, body: "テスト日記") }
  # 投稿に対してコメントするユーザ
  let!(:comment_owner) { create(:owner) }
  let!(:comment_pet) { create(:pet, owner_id: comment_owner.id) }
  let!(:diary_comment) { create(:diary_comment, pet_id: comment_pet.id, diary_id: diary.id,comment: "テストコメント") }
  
  describe "投稿処理(POST #create)" do
    
    context "ログイン済みの場合" do
      before do
        sign_in comment_owner
      end
      it "コメントを投稿できるか" do
        get diary_path(diary)
        post diary_comments_path(pet_id: comment_pet.id, diary_id: diary.id), params: { diary_comment: { comment: "コメントを投稿する"} }, xhr: true
        expect(DiaryComment.find_by(pet_id: comment_pet.id, comment: "コメントを投稿する")).to be_truthy
      end
    end
    
  end
  
  describe "消去処理(DELETE #destroy)" do
    
    context "自分の投稿の場合" do
      before do
        sign_in comment_owner
        get diary_path(diary)
      end
      it "コメントを削除できるか" do
        delete diary_comment_path(diary_id: diary.id), xhr: true
        expect(DiaryComment.find_by(pet_id: comment_pet.id, comment: "テストコメント")).to be_falsey
      end
    end
    
  end
  
end
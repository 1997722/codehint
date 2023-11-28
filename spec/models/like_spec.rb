require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    @like = FactoryBot.build(:like, user_id: user.id, post_id: post.id)
  end

  describe 'いいね機能' do
    context 'いいねできる場合' do
      it "user_idとpost_idがあれば保存できる" do
        expect(@like).to be_valid
      end

      it "post_idが同じでもuser_idが違えばいいねできる" do
        another_like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, user_id: another_like.user_id)).to be_valid
      end

      it "user_idが同じでもpost_idが違えばいいねできる" do
        another_like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, post_id: another_like.post_id)).to be_valid
      end
    end
    context 'いいねできない場合' do
      it "user_idが空ではいいねできない" do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include "User must exist"
      end

      it "post_idが空ではいいねできない" do
        @like.post_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include "Post must exist"
      end
    end

      
  end
end

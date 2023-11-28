require 'rails_helper'

RSpec.describe PostTag, type: :model do
  before do
    @post = FactoryBot.create(:post) # 仮にPostモデルのFactoryを使用してpostを生成
    @tag = FactoryBot.create(:tag) # 仮にTagモデルのFactoryを使用してtagを生成
    @post_tag = FactoryBot.build(:post_tag, post_id: @post.id, tag_id: @tag.id)
  end

  it "post_idとtag_idがある場合、有効であること" do
    expect(@post_tag).to be_valid
  end

  it "post_idがない場合、無効であること" do
    @post_tag.post_id = nil
    expect(@post_tag).to be_invalid
  end

  it "tag_idがない場合、無効であること" do
    @post_tag.tag_id = nil
    expect(@post_tag).to be_invalid
  end
end

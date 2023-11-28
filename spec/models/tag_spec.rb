require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグ付け機能' do
    it 'タグ名がある場合、有効であること' do
      @tag = FactoryBot.create(:tag, tag_name: 'SomeTag') 
      expect(@tag).to be_valid
    end

    it 'タグ名がない場合、無効であること' do
      @tag = FactoryBot.build(:tag, tag_name: '') 
      expect(@tag).to_not be_valid
    end
  end
end

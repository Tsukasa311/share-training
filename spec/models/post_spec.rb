require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  context '投稿ができるとき' do
    it '全ての項目を入力したとき' do
      expect(@post).to be_valid
    end
  end

  context '投稿できないとき' do
    it 'テキストが入力されていないとき' do
      @post.text = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("テキストを入力してください")
    end
    it '部位が空欄のとき' do
      @post.part_id = ""
      @post.valid?
      expect(@post.errors.full_messages).to include("部位を入力してください")
    end
    it '部位において「未選択」を選択したとき' do
      @post.part_id = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("部位が未選択になっています")
    end
    it '器具が空欄のとき' do
      @post.equipment_id = ""
      @post.valid?
      expect(@post.errors.full_messages).to include("器具を入力してください")
    end
    it '器具において「未選択」を選択したとき' do
      @post.part_id = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("部位が未選択になっています")
    end
    it '場所が空欄のとき' do
      @post.place_id = ""
      @post.valid?
      expect(@post.errors.full_messages).to include("場所を入力してください")
    end
    it '場所において「未選択」を選択したとき' do
      @post.place_id = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("場所が未選択になっています")
    end
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  context 'コメントが投稿できるとき' do
    it 'コメント欄に入力したとき' do
      expect(@comment).to be_valid
    end
  end
  context 'コメントが投稿できない時' do
    it 'コメント欄が空欄のとき' do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("テキストを入力してください")
    end
  end
end

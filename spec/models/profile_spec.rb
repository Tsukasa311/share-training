require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
  end

  context 'プロフィールを保存できるとき' do
    it '項目が全て入力済みのとき' do
      expect(@profile).to be_valid
    end
  end

  context 'プロフィールを保存できないとき' do
    it '筋肉トレーニング歴が空のとき' do
      @profile.experience_id = ""
      @profile.valid?
      expect(@profile.errors.full_messages).to include("筋肉トレーニング経験を入力してください")
    end
    it '筋肉トレーニング歴において「未選択」を選択したとき' do
      @profile.experience_id = nil
      @profile.valid?
      expect(@profile.errors.full_messages).to include("筋肉トレーニング経験が未選択になっています")
    end
    it '特に鍛えたい部位が空のとき' do
      @profile.part_id = ""
      @profile.valid?
      expect(@profile.errors.full_messages).to include("特に鍛えたい部位を入力してください")
    end
    it '特に鍛えたい部位において「未選択」を選択した時' do
      @profile.part_id = nil
      @profile.valid?
      expect(@profile.errors.full_messages).to include("特に鍛えたい部位が未選択になっています")
    end
    it 'トレーニング目標頻度が空のとき' do
      @profile.frequency_id = ""
      @profile.valid?
      expect(@profile.errors.full_messages).to include("トレーニング目標頻度を入力してください")
    end
    it 'トレーニング目標頻度において、「未選択」を選択した時' do
      @profile.frequency_id = nil
      @profile.valid?
      expect(@profile.errors.full_messages).to include("トレーニング目標頻度が未選択になっています")
    end
    it '自己紹介が空のとき' do
      @profile.introduction = ""
      @profile.valid?
      expect(@profile.errors.full_messages).to include("自己紹介を入力してください")
    end
    it '自己紹介が101文字以上のとき' do
      @profile.introduction = "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567891"
      @profile.valid?
      expect(@profile.errors.full_messages).to include("自己紹介は100文字以内で入力してください")
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
   @user = FactoryBot.build(:user)
  end

  context "ユーザー登録できるとき" do
    it " 全ての項目で入力済みの時" do
      expect(@user).to be_valid
    end
  end

  context "ユーザー登録できないとき" do
    it "ニックネームが空のとき" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "筋トレ歴が空のとき" do
      @user.experience_id = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Experience can't be blank")
    end
    it "筋トレ歴において「選択してください」を選択したとき" do
      @user.experience_id = 0
      @user.valid?
      expect(@user.errors.full_messages).to include("Experience must be other than 0")
    end
    it "emailが空のとき" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "emailが重複したとき" do
      @user2 = FactoryBot.create(:user)
      @user.email = @user2.email
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end
    it "emailに＠が含まれないとき" do
      @user.email = "123567"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "パスワードが空のとき" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "パスワードが5文字以下のとき" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "パスワードが全角のとき" do
      @user.password = "１２３４５６ＡＢＣ"
      @user.password_confirmation = "１２３４５６ＡＢＣ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "パスワードが半角数字のみのとき" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "パスワードが半角英字のみのとき" do
      @user.password = "asdfgh"
      @user.password_confirmation = "asdfgh"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "passwordとpassword confirmationが一致しないとき" do
      @user.password = "asdfgh123"
      @user.password_confirmation = "zxcvbn456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "password confirmationが空のとき" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end

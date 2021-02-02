require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー情報が保存できるとき' do
    it ' 全ての項目で入力済みの時' do
      expect(@user).to be_valid
    end
  end

  context 'ユーザー情報が保存できないとき' do
    it 'ニックネームが空のとき' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it 'ニックネームが16文字以上のとき' do
      @user.nickname = '0123456789123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームは15文字以内で入力してください")
    end
    it 'emailが空のとき' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it 'emailが重複したとき' do
      @user2 = FactoryBot.create(:user)
      @user.email = @user2.email
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'emailに＠が含まれないとき' do
      @user.email = '123567'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'パスワードが空のとき' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'パスワードが5文字以下のとき' do
      @user.password = '1234a'
      @user.password_confirmation = '1234a'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'パスワードが全角のとき' do
      @user.password = '１２３４５６ＡＢＣ'
      @user.password_confirmation = '１２３４５６ＡＢＣ'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード半角英数字を含める必要があります')
    end
    it 'パスワードが半角数字のみのとき' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード半角英数字を含める必要があります')
    end
    it 'パスワードが半角英字のみのとき' do
      @user.password = 'asdfgh'
      @user.password_confirmation = 'asdfgh'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード半角英数字を含める必要があります')
    end
    it 'passwordとpassword confirmationが一致しないとき' do
      @user.password = 'asdfgh123'
      @user.password_confirmation = 'zxcvbn456'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'password confirmationが空のとき' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
  end
end

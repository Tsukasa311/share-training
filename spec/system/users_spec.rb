require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
   @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録できるとき' do
    it '正しい情報を入力すれば、ユーザー新規登録ができて、登録完了画面に遷移する' do
      # トップページに移動する
      visit root_path
      # トップに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 登録方法選択ページへ移動する
      visit new_user_path
      # 「メールで登録する」と「Googleで登録する」ボタンがあることを確認する
      expect(page).to have_content('メールアドレスで登録')
      expect(page).to have_content('Googleで登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # 「次へ」のボタンを押すとプロフィール登録画面に移動する
      find('input[name="commit"]').click
      # プロフィール登録画面に遷移したことを確認する
      expect(page).to have_content'プロフィール登録'
      # プロフィール情報を入力する
      find("#profile_experience_id").find("option[value='#{@user.profile.experience_id}']").select_option
      find("#profile_part_id").find("option[value='#{@user.profile.part_id}']").select_option
      find("#profile_frequency_id").find("option[value='#{@user.profile.frequency_id}']").select_option
      fill_in 'profile_introduction', with: @user.profile.introduction
      # 「登録」ボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect{find('input[name="commit"]').click}.to change { User.count}.by(1)
      # 登録完了画面に遷移する
      expect(page).to have_content('登録が完了しました')
      # トップページに移動する
      visit root_path
      # 「マイページ」「Shareする」「ログアウト」ボタンが表示されることを確認する
      expect(page).to have_content('マイページ')
       expect(page).to have_content('Shareする')
      expect(page).to have_content('ログアウト')
      # 「ログイン」「新規登録」ボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 登録方法選択ページへ移動する
      visit new_user_path
      # 「メールで登録する」と「Googleで登録する」ボタンがあることを確認する
      expect(page).to have_content('メールアドレスで登録')
      expect(page).to have_content('Googleで登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する（誤り）
      fill_in 'user_nickname', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      # 「次へ」のボタンを押しても画面は遷移しないことを確認する
      find('input[name="commit"]').click
      expect(current_path).to eq "/users"
      # ユーザー情報を入力する(正しく)
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      #「次へ」のボタンを押すとプロフィール登録画面に遷移する
      find('input[name="commit"]').click
      # プロフィール登録画面に遷移したことを確認する
      expect(page).to have_content'プロフィール登録'
      # プロフィール情報を入力する
      find("#profile_experience_id").find("option[value='']").select_option
      find("#profile_part_id").find("option[value='']").select_option
      find("#profile_frequency_id").find("option[value='']").select_option
      fill_in 'profile_introduction', with: ""
      #「登録」ボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { User.count}.by(0)
      # プロフィール登録ページへ戻されることを確認する
      expect(current_path).to eq "/profiles"
    end
  end
end

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it '保存されているユーザー情報と合致したときログインができる' do
      # トップページに移動する
      visit root_path
      # トップページに「ログイン」ボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページに遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # 「ログイン」ボタンを押す
      find("input[name='commit']").click
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      #「マイページ」「Shareする」「ログアウト」ボタンが表示されることを確認する
      expect(page).to have_content('マイページ')
      expect(page).to have_content('Shareする')
      expect(page).to have_content('ログアウト')
      # 「ログイン」「新規登録」ボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインできないとき' do
    it '保存されているユーザー情報と合致しないときログインができない' do
      # トップページに移動する
      visit root_path
      # トップページに「ログイン」ボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページに遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      # 「ログイン」ボタンを押す
      find("input[name='commit']").click
      # ログインページに戻されることを確認する
      expect(current_path).to eq "/users/sign_in"
    end
  end
end

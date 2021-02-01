require 'rails_helper'

RSpec.describe "トレーニング投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context 'トレーニング投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    find("input[name='commit']").click
    expect(current_path).to eq root_path
    # 新規投稿ページへのリンクがあることを確認する
    expect(page).to have_content('Shareする')
    # 新規投稿ページに移動する
    visit new_post_path
    # フォームを入力する
    fill_in 'post[text]', with: @post.text
    find("#post_part_id").find("option[value='#{@post.part_id}']").select_option
    find("#post_equipment_id").find("option[value='#{@post.equipment_id}']").select_option
    find("#post_place_id").find("option[value='#{@post.place_id}']").select_option
    # 送信すると、Postモデルのカウントが１上がることを確認する
    expect{find("input[name='commit']").click}.to change { Post.count }.by(1)
    # マイページに遷移する
    expect(current_path).to eq "/users/#{@user.id}"
    # マイページに先ほど投稿した内容のトレーニングが存在することを確認する
    expect(page).to have_content(@post.text)
    end
  end

  context 'トレーニング投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに移動する
      visit root_path
      # 新規投稿ページに移動しようとすると、ログインページに遷移することを確認する
      visit new_post_path
      expect(current_path).to eq "/users/sign_in"
    end
  end
end



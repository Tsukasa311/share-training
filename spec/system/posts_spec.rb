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

RSpec.describe 'トレーニング投稿削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  
  context 'トレーニング投稿が削除できるとき' do
    it 'ログインしたユーザーは自らが投稿したトレーニング投稿を削除できる' do
      # トレーニング１を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post1.user.email
      fill_in 'user_password', with: @post1.user.password
      find("input[name='commit']").click
      expect(current_path).to eq root_path
      # マイページに移動する
      visit user_path(@post1.user_id)
      # トレーニング１に「削除」ボタンがあることを確認する
      expect(all(".more")[0].hover).to have_link '削除', href: "/posts/#{@post1.id}"
      # 投稿を削除すると、レコードが１減ることを確認する
      expect{
      page.accept_confirm do
        all(".more")[0].hover.click_link('削除', href: post_path(@post1.id))
      end
      expect(page).to have_content('投稿を削除しました！')
      }.to change { Post.count }.by(-1)
      # マイページに遷移したことを確認する
      expect(current_path).to eq user_path(@post1.user.id)
      # マイページにトレーニング１が存在しないことを確認する
      expect(page).to have_no_content(@post1.text)
    end
  end

  context 'トレーニング投稿が削除できないとき' do
    it 'ログインしたユーザーは自分以外のトレーニング投稿を削除できない' do
      # トレーニング１を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post1.user.email
      fill_in 'user_password', with: @post1.user.password
      find("input[name='commit']").click
      expect(current_path).to eq root_path
      # トレーニング2を投稿したユーザーのマイページに移動する
      visit user_path(@post2.user_id)
      # トレーニング２に「削除」ボタンがないことを確認する
      expect(all(".more")[0].hover).to have_no_link '削除', href: "/posts/#{@post1.id}"
    end
  end
end



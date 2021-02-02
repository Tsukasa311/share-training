require 'rails_helper'

RSpec.describe "コメント機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    @comment = FactoryBot.build(:comment)
  end

  it 'ログインしたユーザーは、トレーニング投稿詳細ページでコメントが投稿' do
    # ログインする
    sign_in(@user)
    # トレーニング投稿詳細ページに遷移する
    find(".search_btn").click
    expect((all(".more")[0].hover)).to have_link '詳細', href: "/posts/#{@post.id}"
    visit post_path(@post.id)
    # フォームに情報を入力する
    fill_in 'comment[text]', with: @comment.text
    # コメントを送信すると、Commentモデルのカウントが１上がるり、コメントした投稿がページに存在することを確認する
    expect{
      find("#comment_submit").click
      expect(page).to have_content(@comment.text)
    }.to change { Comment.count }.by(1) 
  end
  it '投稿したコメントは、投稿者本人は削除できる' do
    # ログインする
    sign_in(@user)
    # トレーニング投稿詳細ページに遷移する
    find(".search_btn").click
    expect((all(".more")[0].hover)).to have_link '詳細', href: "/posts/#{@post.id}"
    visit post_path(@post.id)
    # フォームに情報を入力する
    fill_in 'comment[text]', with: @comment.text
    # コメントを送信すると、Commentモデルのカウントが１上がるり、コメントした投稿がページに存在することを確認する
    expect{
      find("#comment_submit").click
      expect(page).to have_content(@comment.text)
    }.to change { Comment.count }.by(1)
    # 「コメントを削除」ボタンが表示されていることを確認する
    expect(page).to have_content('コメントを削除')
    # コメントを削除すると、Commentモデルのカウントが１下がり、削除したコメントがページに存在しないことを確認する
    expect{
      find(".comment_delete").click
      expect(page).to have_no_content(@comment.text)
    }.to change { Comment.count }.by(-1)
  end
  it 'コメントした本人以外は、コメントを削除できない' do
    # ログインして投稿にコメントする
    sign_in(@user)
    find(".search_btn").click
    expect((all(".more")[0].hover)).to have_link '詳細', href: "/posts/#{@post.id}"
    visit post_path(@post.id)
    fill_in 'comment[text]', with: @comment.text
    find("#comment_submit").click
    expect(page).to have_content('コメントを削除')
    # ログアウトする
    link = find_link 'ログアウト', href: "/users/sign_out"
    link.click
    # 別のユーザーでログインする
    sign_in(@post.user)
    # 先ほどの投稿詳細画面に移動する
    visit post_path(@post.id)
    # 「コメント削除」ボタンが表示されていないことを確認する
    expect(page).to have_no_link('コメントを削除')
  end
end

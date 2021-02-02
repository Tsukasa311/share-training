require 'rails_helper'

RSpec.describe "コメント機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    @comment = FactoryBot.build(:comment)
  end

  it 'ログインしたユーザーは、トレーニング投稿詳細ページでコメントが投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    find("input[name='commit']").click
    expect(current_path).to eq root_path
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
end

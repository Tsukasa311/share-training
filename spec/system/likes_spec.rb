require 'rails_helper'

RSpec.describe "NiceTraining(いいね)機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  it 'ログインしているユーザーは、トレーニング投稿に対してNiceTrainingできる' do
    # ログインする
    sign_in(@user)
    # 投稿一覧ページに移動する
    find(".search_btn").click
    # 「NiceTraining」ボタンがあることを確認する
    expect(page).to have_content("NiceTraining:0")
    expect(page).to have_no_content("NiceTraining:1")
    # 「NiceTraining」ボタンを押すと、Likeモデルのカウントが１上がり、表示が0から1になることを確認する
    expect{
      find("#post_like_#{@post.id}").click
      expect(page).to have_content("NiceTraining:1")
      expect(page).to have_no_content("NiceTraining:0")
    }.to change { Like.count }.by(1)
    # もう一度「NiceTraining」ボタンを押すと、Likeモデルのカウントが１下がり、表示が1から0になることを確認する
    expect{
      find("#post_like_#{@post.id}").click
      expect(page).to have_content("NiceTraining:0")
      expect(page).to have_no_content("NiceTraining:1")
    }.to change { Like.count }.by(-1)
  end
end

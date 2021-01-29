# アプリケーション名
Share Training
# アプリケーション概要
ユーザー登録、ログインをしたユーザーは、筋肉トレーニングメニューを投稿、検索できる。
またユーザーごとのマイページで、いつ、どこの部位の筋肉トレーニングを行ったのか簡単に確認することができる。
# URL
https://share-training.herokuapp.com/
# テスト用アカウント
basic認証
- username: user
- password: password
# 利用方法
画面右上のログイン画面から必要事項を記入しログインを行う。
ログイン完了後は、5つの機能を扱える。
- 投稿検索機能
画面中央の検索ボックス、または画面下部のボタンから、カテゴリーを選んで投稿を検索することができる。検索ボックスでは、条件を複数設定しての検索が可能。
- 投稿機能
画面右上の「Shareする」のボタンから、投稿作成画面に移動する。
「トレーニングメニュー」「部位」「器具」「場所」をそれぞれ入力・選択し投稿することができる。
- マイページ機能
投稿後はマイページに遷移する。
ここでは、ユーザーのプロフィール、日別の投稿記録、投稿した部位別の割合を確認をすることができる。
また画面株では過去の投稿、いいねをした投稿の一覧も確認することができる。
- Nice training(いいね)機能
投稿の右下に「NiceTraining]という文字、もしくは腕のアイコンをクリックするとNice training(いいね)され、カウントが1つ増える。投稿の右上にあるプルダウンボタンから「詳細」をクリックすると、投稿の詳細画面に遷移する。投稿詳細画面では、投稿と、その投稿に「Nice training」したユーザー一覧を確認することができる。
- コメント機能
投稿詳細画面にあるコメント投稿フォームからコメントを投稿することができる。
コメントフォームの下には、投稿に対して行われたコメントが一覧で表示される。
# 目指した課題解決
「世の中の人が、どういったメニューで日々の筋肉トレーニングを行っているのか知りたい」という課題
# 洗い出した要件

# 実装した機能
- ユーザー管理
- SNS認証（Google）
- 投稿の保存・削除
- 複雑検索
- いいね
- コメント保存・削除
- カレンダー
- グラフ化

# 開発環境
- Ruby 2.6.5
- Rails 6.0.3.4

# usersテーブル
| Column        | Type           | Option                         |
|---------------|----------------|--------------------------------|
| nickname      | string         | null: false                    |
| email         | string         | null: false, unique: true      |

## association
user has_many :comments
user has_many :posts
user has_one :profile


# profilesテーブル
| Column        | Type           | Option                         |
|---------------|----------------|--------------------------------|
| user_id       | references     |                                |
| experience_id | integer        | null: false                    |
| part_id       | integer        | null: false                    |
| frequency_id  | integer        | null: false                    |
| introduction  | string         | null: false                    |

## association
profile belongs_to :user, optional: true

# commentsテーブル
| Column       | Type           | Option                         |
|--------------|----------------|--------------------------------|
| text         | string         | null: false                    |
| user_id      | references     | null: false, foreign_key: true |
| post_id      | references     | null: false, foreign_key: true |

## association
comment belongs_to :user
comment belongs_to :post


# postsテーブル 
| Column       | Type           | Option                         |
|--------------|----------------|--------------------------------|
| text         | string         | null: false                    |
| user_id      | references     | null: false, foreign_key: true |
| part_id      | integer        | null: false                    |
| equipment_id | integer        | null: false                    |
| place_id     | integer        | null: false                    |

## association
belongs_to :user
post has_many :post_tags
post has_many :tags, through: :post_tags

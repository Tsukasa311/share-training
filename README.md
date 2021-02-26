# アプリケーション名
 **Share Training**

# アプリケーション概要
ユーザー登録、ログインをしたユーザーは、筋肉トレーニングメニューを投稿、検索できる。
またユーザーごとのマイページで、いつ、どこの部位の筋肉トレーニングを行ったのか簡単に確認することができる。

# URL
https://share-training.herokuapp.com/

# テスト用アカウント
basic認証
- username: user
- password: password
アカウント
- email: test1@test1
- password: test1111

# 利用方法
画面右上のログイン画面から必要事項を記入しログインを行う。
ログイン完了後は、5つの機能を扱える。
- 投稿検索機能<br>
画面中央の検索ボックス、または画面下部のボタンから、カテゴリーを選んで投稿を検索することができる。検索ボックスでは、条件を複数設定しての検索が可能。
- 投稿機能<br>
画面右上の「Shareする」のボタンから、投稿作成画面に移動する。
「トレーニングメニュー」「部位」「器具」「場所」をそれぞれ入力・選択し投稿することができる。
- マイページ機能<br>
投稿後はマイページに遷移する。
ここでは、ユーザーのプロフィール、日別の投稿記録、投稿した部位別の割合を確認をすることができる。
また画面株では過去の投稿、いいねをした投稿の一覧も確認することができる。
- Nice training(いいね)機能<br>
投稿の右下に「NiceTraining]という文字、もしくは腕のアイコンをクリックするとNice training(いいね)され、カウントが1つ増える。投稿の右上にあるプルダウンボタンから「詳細」をクリックすると、投稿の詳細画面に遷移する。投稿詳細画面では、投稿と、その投稿に「Nice training」したユーザー一覧を確認することができる。
- コメント機能<br>
投稿詳細画面にあるコメント投稿フォームからコメントを投稿することができる。
コメントフォームの下には、投稿に対して行われたコメントが一覧で表示される。

# 目指した課題解決
私(開発者)の、「世の中の人がどういったメニューで日々の筋肉トレーニングを行っているのか知りたい」という課題

# 要件定義
|機能|目的|詳細|
|-|-|-|
|ユーザー管理機能|ユーザーごとのデータを管理できるようにする|ログインをすることで、投稿や検索などアプリケーションの機能を利用することができる|
|SNS認証機能|ユーザーアカウント登録方法を簡単にする|Googleアカウントを利用したログイン方法を選択肢として追加する<br>SNS認証を選択した場合は、名前、メールアドレス、パスワードは入力された状態で表示される。(パスワードは表示されない)|
|複雑検索機能|欲しい情報にすぐに辿り着けるようにする|条件を複数選択した後、検索ボタンをクリックすると、該当する投稿が一覧表示される|
|投稿機能|情報発信を可能にする|ユーザーがその日行ったトレーニングを投稿することができる<br>入力に誤りがなければデータベースに保存され、マイページに遷移する<br>テキストは210文字以内<br>投稿には、トレーニングメニュー、鍛えた部位、使用した器具、トレーニング場所の情報を盛り込む必要がある<br>投稿に失敗するとエラーメッセージが表示され、投稿ページに遷移する|
|いいね機能|投稿内容に対して好意を表現する|いいねボタンをクリックすると、ボタンの色が変化（いいね済み）し、いいねカウントが１つ増える（非同期通信）<br>１つの投稿に対して１回のいいねが可能|
|コメント機能|投稿内容に対して質問や意見交換をする|コメントフォームにテキストを入力し、投稿ボタンをクリックすると、投稿詳細画面にコメントが表示される（非同期通信）|
|グラフ機能|ユーザーの投稿に紐づくカテゴリーの割合を表示し、トレーニングの傾向を知ることができる|ユーザーの詳細ページ（マイページ）にて確認可能|
|カレンダー機能|いつ、どこの部位のトレーニングを行ったかをひと目で確認することができる|ユーザーの詳細ページ（マイページ）にて確認可能<br>ユーザーが投稿をすると、カレンダーにどこの部位のトレーニングを行ったかが表示される|

# 実装した機能
- ユーザー管理
- SNS認証（Google）
- 投稿の保存・削除
- 複雑検索
- いいね
- コメント保存・削除
- カレンダー
- グラフ化
- 画像投稿機能（保存先：AWS（S3））

# 開発環境
- Ruby 2.6.5
- Rails 6.0.3.4

# ER図
![share-training](https://user-images.githubusercontent.com/70062121/106223242-62bf9700-6224-11eb-8c98-75e3bf0c300b.png)

# usersテーブル
| Column        | Type           | Option                         |
|---------------|----------------|--------------------------------|
| nickname      | string         | null: false                    |
| email         | string         | null: false, unique: true      |

## association
user has_many :posts
user has_one :profile
user has_many :likes
user has_many :liked_posts, through: :likes, source: :post
user has_many :comments


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
post belongs_to :user
post has_many :likes
post has_many :liked_users, through: :likes, source: :user

# likesテーブル
| Column       | Type           | Option                         |
|--------------|----------------|--------------------------------|
|user_id       |references      |null: false, foreign_key: true  |
|post_id       |references      |null: false, foreign_key: true  |

## association
like  belongs_to :post
like  belongs_to :user
# usersテーブル
| Column        | Type           | Option                         |
|---------------|----------------|--------------------------------|
| nickname      | string         | null: false                    |
| email         | string         | null: false, unique: true      |
| experience_id | integer        | null: false                    |
| target_id     | integer        | null: false                    |
| introduction  | string         | null: false                    |

## association
user has_many :comments
user has_many :posts


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

## association
post has_many :post_tags
post has_many :tags, through: :post_tags


# tagsテーブル
| Column        | Type          | Option                         |
|---------------|---------------|--------------------------------|
| name          | string        | null: false, unique: true      |

## association
tag has_many :pots_tags
tag has_many :posts, through: :post_tags


# post_tagsテーブル
| Column        | Type          | Option                         |
|---------------|---------------|--------------------------------|
| post_id       | references    | null: false, foreign_key: true |
| tag_id        | references    | null: false, foreign_key: true |

## association
post_tag belongs_to :post
post_tag belongs_to :tag

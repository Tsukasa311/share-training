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


# tagsテーブル
| Column        | Type          | Option                         |
|---------------|---------------|--------------------------------|
| name          | string        | null: false, uniqueness: true  |

## association
tag has_many :pots_tags
tag has_many :posts, through: :post_tags


# post_tag_relationテーブル
| Column        | Type          | Option                         |
|---------------|---------------|--------------------------------|
| post_id       | references    | null: false, foreign_key: true |
| tag_id        | references    | null: false, foreign_key: true |

## association
post_tag belongs_to :post
post_tag belongs_to :tag

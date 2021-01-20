class Place < ActiveHash::Base
  self.data = [
    { id: 0, name: 'トレーニング場所選択'},
    { id: 1, name: '自宅'},
    { id: 2, name: 'ジム'}
  ]

  include ActiveHash::Associations
  has_many :posts

end
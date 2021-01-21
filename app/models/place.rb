class Place < ActiveHash::Base
  self.data = [
    { id: 1, name: '自宅' },
    { id: 2, name: 'ジム' }
  ]

  include ActiveHash::Associations
  has_many :posts
end

class Place < ActiveHash::Base
  self.data = [
    { id: 1, name: '自宅' },
    { id: 2, name: 'ジム' },
    { id: 3, name: '屋外' }
  ]

  include ActiveHash::Associations
  has_many :posts
end

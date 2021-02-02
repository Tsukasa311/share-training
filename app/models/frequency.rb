class Frequency < ActiveHash::Base
  self.data = [
    { id: 1, name: '週1~2回' },
    { id: 2, name: '週3' },
    { id: 3, name: '週4~5' },
    { id: 4, name: '週6以上' },
  ]

  include ActiveHash::Associations
  has_many :profiles
end

class Part < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '大胸筋' },
    { id: 2, name: '上腕二頭筋' }
  ]

  include ActiveHash::Associations
  has_many :Profiles
end

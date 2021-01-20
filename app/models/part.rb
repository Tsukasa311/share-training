class Part < ActiveHash::Base
  self.data = [
    { id: 0, name: '部位を選択' },
    { id: 1, name: '大胸筋' },
    { id: 2, name: '上腕二頭筋' },
    { id: 3, name: '上腕三頭筋'},
    { id: 4, name: '肩'},
    { id: 5, name: '広背筋'},
  ]

  include ActiveHash::Associations
  has_many :Profiles
  has_many :posts
end

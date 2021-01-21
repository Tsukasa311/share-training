class Part < ActiveHash::Base
  self.data = [
    { id: 1, name: '大胸筋' },
    { id: 2, name: '広背筋・僧帽筋' },
    { id: 3, name: '肩・三角筋' },
    { id: 4, name: '上腕二頭筋' },
    { id: 5, name: '上腕三頭筋' },
    { id: 6, name: '腹筋' },
    { id: 7, name: '尻・大臀筋' },
    { id: 8, name: '脚・大腿四頭筋' }
  ]

  include ActiveHash::Associations
  has_many :Profiles
  has_many :posts
end

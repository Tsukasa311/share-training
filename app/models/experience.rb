class Experience < ActiveHash::Base
  self.data = [
    { id: 1, name: '1ヶ月未満' },
    { id: 2, name: '1〜3ヶ月' },
    { id: 3, name: '半年程度' },
    { id: 4, name: '1年以上' },
    { id: 5, name: '2年以上' },
    { id: 6, name: '5年以上' },
    { id: 7, name: '10年以上' },
    { id: 8, name: '20年以上' }
  ]

  include ActiveHash::Associations
  has_many :profiles
end

class Equipment < ActiveHash::Base
  self.data = [
    { id: 1, name: '身体一つ！' },
    { id: 2, name: 'ダンベル' },
    { id: 3, name: 'ダンベル+インクラインベンチ' },
    { id: 4, name: 'ヨガマット' },
    { id: 5, name: 'ジムマシン'},
    { id: 6, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts
end

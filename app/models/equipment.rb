class Equipment < ActiveHash::Base
  self.data = [
    { id: 1, name: '身体一つ！' },
    { id: 2, name: 'ダンベル' },
    { id: 3, name: 'インクラインベンチ' },
    { id: 4, name: 'ダンベル+インクラインベンチ' },
    { id: 5, name: 'ヨガマット' },
    { id: 6, name: 'ジムマシン'},
    { id: 7, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts
end

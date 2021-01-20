class Equipment < ActiveHash::Base
  self.data = [
    { id: 0, name: '器具を選択' },
    { id: 1, name: '自重のみ'},
    { id: 2, name: 'ダンベル' },
    { id: 3, name: 'インクラインベンチ'},
    { id: 4, name: 'ダンベル+インクラインベンチ'},
    { id: 5, name: 'ヨガマット'}
  ]

  include ActiveHash::Associations
  has_many :posts

end

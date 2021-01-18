class Frequency < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '週１' },
    { id: 2, name: '週４' }
  ]

  include ActiveHash::Associations
  has_many :Profiles
end

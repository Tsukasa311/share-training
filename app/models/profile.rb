class Profile < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image

  with_options presence: true do
    validates :experience_id, numericality: { other_than: 0 }
    validates :part_id, numericality: { other_than: 0 }
    validates :frequency_id,  numericality: { other_than: 0 }
    validates :introduction,  length: { maximum: 250 }
  end
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :frequency
  belongs_to :part
  belongs_to :experience
end

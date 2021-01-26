class Profile < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image

  with_options presence: true do
    validates :experience_id, numericality: { only_integer: true, message: "が未選択になっています"}
    validates :part_id, numericality: { only_integer: true, message: "が未選択になっています"  }
    validates :frequency_id,  numericality: { only_integer: true, message: "が未選択になっています" }
    validates :introduction,  length: { maximum: 100 }
  end
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :frequency
  belongs_to :part
  belongs_to :experience
end

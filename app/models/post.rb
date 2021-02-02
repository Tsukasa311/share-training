class Post < ApplicationRecord
  belongs_to :user
  has_many :comments,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :part
  belongs_to :equipment
  belongs_to :place

  with_options presence: true do
    validates :text,          length: { maximum: 210 }
    validates :part_id,       numericality: { only_integer: true, message: "が未選択になっています"}
    validates :equipment_id,  numericality: { only_integer: true, message: "が未選択になっています"}
    validates :place_id,      numericality: { only_integer: true, message: "が未選択になっています"}
  end
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :part
  belongs_to :equipment
  belongs_to :place

  with_options presence: true do
    validates :text
    validates :part_id,       numericality: { other_than: 0 }
    validates :equipment_id,  numericality: { other_than: 0 }
    validates :place_id,      numericality: { other_than: 0 }
  end
end

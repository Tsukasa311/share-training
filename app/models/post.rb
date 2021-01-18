class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations

  validates :text, presence: true

  def self.search(search) 
    if search != ""
      Post.where("text LIKE(?)", "%#{search}%")
    else
      Post.all
    end
  end
end

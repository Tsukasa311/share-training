class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :Experience

  with_options presence: true do
    validates :nickname, length: { maximum: 30 }
    validates :experience_id, numericality: { other_than: 0 }
    validates :introduction, length: { maximum: 200 }
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i.freeze, message: "Include both letters and numbers"}
end

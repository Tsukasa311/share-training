class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :profile
  has_many :sns_credentials
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  validates :nickname, presence: true, length: { maximum: 30 }
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i.freeze, message: '半角英数字を含める必要があります' }

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns } # 返り値
  end
end

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :categories, dependent: :destroy

  before_save { self.email = email.downcase }

  validates :name, presence: true

  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password

end

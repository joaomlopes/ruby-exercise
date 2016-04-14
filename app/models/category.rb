class Category < ActiveRecord::Base
  belongs_to :user
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }

  validates_uniqueness_of :name

end

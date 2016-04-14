class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5, maximum: 50}
  validates :body, presence: true, length: {minimum: 5, maximum: 500}

  def self.search(search)
    p = Post.arel_table
    where(
        p[:title].matches("%#{search}%").
            or(p[:body].matches("%#{search}%"))
    )
  end

end

class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image

  has_many :ingredients, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :image, presence: true
  validates :title, presence: true
  validates :description, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :user_id, presence: true
  validates :title, presence: true
end

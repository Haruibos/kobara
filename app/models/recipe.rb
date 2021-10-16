class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image

  has_many :ingredients, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  validates :user_id, presence: true
  validates :title, presence: true
end

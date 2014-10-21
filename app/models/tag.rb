class Tag < ActiveRecord::Base
  has_many :skills_tags
  has_many :skills, through: :skills_tags

  scope :categories, -> { where(is_category: true).order("created_at ASC") }
  scope :non_categories, -> { where(is_category: false).order("created_at ASC") }
end
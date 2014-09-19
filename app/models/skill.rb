class Skill < ActiveRecord::Base
  belongs_to :expert, foreign_key: 'user_id', class_name: 'User'
  has_many :skills_tags
  has_many :tags, through: :skills_tags

  validates_presence_of :expert, :description, :price, :title

  def categories
    tags.where(is_category: true)
  end

  def assign_tags(*tag_names)
    tag_names.each do |tag_name|
      tag_name.strip!

      if not (tag = Tag.find_by(name: tag_name))
        tag = Tag.create(name: tag_name)
      end

      tags.push tag
    end
    save!
  end

  def update_tags(*tag_names)
    tags.destroy_all
    assign_tags(*tag_names)
  end
end
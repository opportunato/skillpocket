class Skill < ActiveRecord::Base
  belongs_to :expert, foreign_key: 'user_id', class_name: 'User'
  has_many :skills_tags
  has_many :tags, through: :skills_tags

  SMARTPHONE_OSES = %w[iOS Android Other]
  CATEGORIES=%w[Technology Business Marketing\ &\ Sales Skills\ &\ Management Product\ &\ Design Funding Photo\ &\ Video Writing]
  NEW_CATEGORIES=%w[Developer Designer Marketer Business\ Consultant Creative]

  validates_presence_of :expert, :price, :title
  validates :title, length: { maximum: 110 }
  validates :price, numericality: { only_integer: true }
  validates :smartphone_os, inclusion: { in: SMARTPHONE_OSES }

  enum category: NEW_CATEGORIES

  attr_accessor :tags_text, :categories_list

  def tags_text
    @tags_text || tags.map(&:name).reduce do |string, tag|
      string + ", " + tag
    end
  end

  def tags_text=(tags_text)
    @tags_text = tags_text
  end

  def categories
    tags.categories
  end

  def categories_text
    tags.categories.map(&:name).reduce do |string, category|
      string + ", " + category
    end
  end

  def categories_list
    @categories_list || tags.categories.map(&:name)
  end

  def categories_list=(categories_list)
    @categories_list = categories_list
  end

  def assign_tags(*tag_names)
    tag_names.each do |tag_name|
      tag_name.strip!

      if tag_name.present? 
        if !(tag = Tag.find_by(name: tag_name))
          tag = Tag.create(name: tag_name)
        end

        if !(tags.exists?(name: tag_name))
          tags.push tag
        end
      end
    end
    save!
  end

  def update_tags(*tag_names)
    tags.destroy_all
    assign_tags(*tag_names)
  end
end

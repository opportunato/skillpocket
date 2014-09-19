class User < ActiveRecord::Base
  has_one :skill, dependent: :destroy

  validates_presence_of :first_name, :last_name

  scope :with_category, -> category { joins(skill: :tags).where("tags.is_category" => true, "tags.name" => category) }

  delegate :price,
           to: :skill

  delegate :description, :title, :tags, :categories,
           to: :skill,
           prefix: true

  store_accessor :links, :website_link, :twitter_link, :linkedin_link, :behance_link, :github_link, :stackoverflow_link

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  mount_uploader :photo, UserPhotoUploader
  mount_uploader :profile_banner, UserBannerUploader

  def expert?
    skill.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
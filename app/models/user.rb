class User < ActiveRecord::Base
  include Messageable

  has_one :skill, dependent: :destroy

  validates_presence_of :full_name, :email, :job, :about, :photo, :profile_banner

  scope :with_category, -> category { joins(skill: :tags).where("tags.is_category" => true, "tags.name" => category) }

  delegate :price,
           to: :skill

  delegate :title, :tags, :categories,
           to: :skill,
           prefix: true

  URLS = %w[website_url twitter_url facebook_url linkedin_url behance_url github_url stackoverflow_url]

  store_accessor :urls, *URLS

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  mount_uploader :photo, UserPhotoUploader
  mount_uploader :profile_banner, UserBannerUploader

  def expert?
    skill.present?
  end

  def update_skill(skill_params)
    if skill.present?
      skill.update(skill_params)
    else
      self.skill = Skill.create(skill_params)
    end
  end
end

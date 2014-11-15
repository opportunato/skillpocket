class User < ActiveRecord::Base
  include Messageable
  include Redis::Objects

  has_one :skill, dependent: :destroy
  has_many :user_friended_experts
  has_many :user_followers, foreign_key: :expert_id, class_name: 'UserFriendedExpert', dependent: :destroy

  validates_presence_of :full_name, :email, :job, :about, :photo
  validates :job, length: { maximum: 40 }
  validates :about, length: { maximum: 500 }
  validates :email, email: true

  before_validation :add_protocol_for_urls

  # TODO extremely bad style, need to fix it somehow
  def add_protocol_for_urls
    URLS.each do |url|
      if self.send(url).present? && self.send(url) != ""
        unless self.send(url)[/\Ahttp:\/\//] || self.send(url)[/\Ahttps:\/\//]
          self.send("#{url}=", "http://#{self.send(url)}")
        end
      end
    end
  end

  scope :with_category, -> category { joins(skill: :tags).where("tags.is_category" => true, "tags.name" => category) }
  scope :with_any_category, -> category { joins(skill: :tags).where("tags.name" => category) }
  scope :experts, -> { joins(:skill) }
  scope :from_twitter, -> { where.not('users.twitter_id' => nil) }
  scope :unapproved, -> { where(approved: false) }
  scope :approved, -> { where(approved: true) }
  scope :experts, -> { joins(:skill) }
  scope :near_user, -> user { near([user.latitude, user.longitude], user.max_search_distance, units: :km) }

  scope :by_rating, -> user { joins("LEFT JOIN user_friended_experts ON user_friended_experts.expert_id = users.id AND user_friended_experts.user_id = #{user.id}").order("coalesce(user_friended_experts.id, -1) desc, social_authority desc, users.created_at desc") }

  geocoded_by :ip_address
  after_validation :geocode, unless: :location_defined?

  delegate :price, :smartphone_os,
           to: :skill

  delegate :title, :tags, :categories, :categories_text,
           to: :skill,
           prefix: true

  accepts_nested_attributes_for :skill

  URLS = %w[website_url twitter_url facebook_url linkedin_url behance_url github_url stackoverflow_url]

  store_accessor :urls, *URLS

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  mount_uploader :photo, UserPhotoUploader
  mount_uploader :profile_banner, UserBannerUploader

  set :twitter_friends
  set :twitter_followers

  def expert?
    skill.present?
  end

  def is_followed(user)
    user_followers.select { |expert| expert.user_id == user.id }.length > 0
  end

  def admin?
    role == "admin"
  end

  def approve
    self.approved = true
    self.save(validate: false)
  end

  def self.admin
    where(role: "admin").first
  end

  def self.find_by_handle(handle)
    where("lower(twitter_handle) = ?", handle.downcase).first
  end

  def update_location location, ip
    if location
      self.latitude = location.latitude
      self.longitude = location.longitude
    end
    self.ip_address = ip
    save
  end

  def location_defined?
    self.latitude && self.longitude
  end
end

class User < ActiveRecord::Base
  include Messageable
  include Redis::Objects

  has_one  :skill, dependent: :destroy
  has_many :user_friended_experts
  has_many :user_followers, foreign_key: :expert_id, class_name: 'UserFriendedExpert', dependent: :destroy

  validates_presence_of :full_name, :photo, :email, :job
  validates :job, length: { maximum: 40 }
  validates :about, length: { maximum: 500 }
  # validates :email, email: true

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
  scope :with_any_new_category, -> category { joins(:skill).where("skills.category = ?", Skill.categories[category]) }
  
  scope :developers, -> { with_any_new_category("Developer") }
  scope :designers, -> { with_any_new_category("Designer") }
  scope :business, -> { with_any_new_category("Business Consultant") }
  scope :marketers, -> { with_any_new_category("Marketer") }
  scope :creatives, -> { with_any_new_category("Creative") }

  scope :from_twitter, -> { where.not('users.twitter_id' => nil) }
  scope :unapproved, -> { where(approved: false) }
  scope :approved, -> { where(approved: true) }
  scope :not_featured, -> { where(is_featured: false) }
  scope :featured, -> { where(is_featured: true) }
  scope :experts, -> { joins(:skill) }
  scope :near_user, -> user {
    geocoded.
    near([user.latitude, user.longitude], user.max_search_distance).
    reorder('') # we didn't ask to sort by distance
  }
  scope :by_rating, -> user {
    near_user(user).
    include_is_followed(user).
    # intermediate_followers_count(user).
    order('is_followed DESC').
    # order('intermediate_followers_count DESC'). # not using this just yet
    order(social_authority: :desc).
    order('distance DESC').
    order(created_at: :desc)
  }
  # duplication, change later
  scope :by_rating_for_view, -> user {
    # include_is_followed(user).
    # # intermediate_followers_count(user).
    # order('is_followed DESC').
    # order('intermediate_followers_count DESC'). # not using this just yet
    order(social_authority: :desc).
    order(created_at: :desc)
  }
  scope :by_authority, -> { order("social_authority desc, users.created_at desc") }
  scope :include_is_followed, -> user {
    joins("LEFT OUTER JOIN user_friended_experts ON user_friended_experts.expert_id = users.id AND user_friended_experts.user_id = #{user.id}").
    select('COUNT(user_friended_experts) as is_followed').
    group('users.id')
  }
  # scope :include_intermediate_followers_count, -> user {
  #   joins("LEFT OUTER JOIN user_friended_expert_followers ON user_friended_expert_followers.expert_id = users.id AND user_friended_expert_followers.user_id = #{user.id}").
  #   select('COUNT(user_friended_expert_followers) as intermediate_followers_count').
  #   group('users.id')
  # }

  geocoded_by :ip_address
  after_validation :geocode, unless: :location_defined?

  delegate :price, :smartphone_os, :category,
           to: :skill,
           allow_nil: true

  delegate :title, :tags, :tags_text, :categories, :categories_text,
           to: :skill,
           prefix: true,
           allow_nil: true

  accepts_nested_attributes_for :skill

  URLS = %w[website_url twitter_url facebook_url linkedin_url behance_url github_url stackoverflow_url angellist_url dribble_url]

  store_accessor :urls, *URLS

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  mount_uploader :photo, UserPhotoUploader
  mount_uploader :profile_banner, UserBannerUploader

  set :twitter_friends
  set :twitter_followers

  def first_name
    full_name.split(/\s+/).select { |part| part.present? }.first
  end

  def expert?
    skill.present?
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

class ExpertsController < ApplicationController
  skip_before_action :authenticate!, only: [:index]

  #TODO Abomination, needs rewriting
  def index
    state = get_city_and_category_state(params[:category], params[:city], User.approved.experts.from_twitter)

    @title       = state[:title]
    @description = state[:description]
    @title_text  = state[:title_text]

    @categories  = CATEGORIES.map { |category_url, category| [ category[:name], state[:category_path].call(category_url) ] }
    @categories.unshift(["all professionals", state[:all_categories_path]])

    @cities      = CITIES.map     { |city_url, city| [ city[:name], state[:city_path].call(city_url) ] }
    @cities.unshift(["all cities", state[:all_cities_path]])

    if current_user.present?
      @experts = state[:experts].by_rating_for_view(current_user)
    else
      @experts = state[:experts].by_authority
    end

    @experts = UserDecorator.decorate_collection(@experts)

    @is_expert = current_user.present? && current_user.expert?
  end

private

  # In heavy need for refactoring, if adding new features needs to be done in instant
  def get_city_and_category_state(category, city, experts)
    if category_data = CATEGORIES[category]
      experts = experts.with_any_category(category_data[:name])

      if city_data = CITIES[city]
        title = "Hire #{category_data[:title]} in #{city_data[:title]}"
        title_text = "#{category_data[:title]} in #{city_data[:title]}"
        description_experts = "#{category_data[:title]} in #{city_data[:title]}"
        experts = experts.near([city_data[:latitude], city_data[:longitude]], 48, units: :km)

        city_path = Proc.new { |city| category_city_experts_path(category: category, city: city) }
        all_cities_path = category_experts_path(category: category)
        category_path = Proc.new { |category| category_city_experts_path(category: category, city: city) }
        all_categories_path = category_experts_path(category: city)
      else
        title = "Hire #{category_data[:title]}"
        title_text = "#{category_data[:title]}"
        description_experts = category_data[:title]

        city_path = Proc.new { |city| category_city_experts_path(category: category, city: city) }
        all_cities_path = category_experts_path(category: category)
        category_path = Proc.new { |category| category_experts_path(category: category) }
        all_categories_path = experts_path
      end
    elsif (city_data = CITIES[category]) && (city = category)
      title = "Hire experts in #{city_data[:title]}"
      title_text = "Experts in #{city_data[:title]}"
      description_experts = city_data[:title]
      experts = experts.near([city_data[:latitude], city_data[:longitude]], 48, units: :km)
      
      city_path = Proc.new { |city| category_experts_path(category: city) }
      all_cities_path = experts_path
      category_path = Proc.new { |category| category_city_experts_path(category: category, city: city) }
      all_categories_path = category_experts_path(category: city)
    else
      title = "Hire experts"
      title_text = "Experts"
      description_experts = "experts"
      experts = experts

      city_path = Proc.new { |city| category_experts_path(category: city) }
      all_cities_path = experts_path
      category_path = Proc.new { |category| category_experts_path(category: category) }
      all_categories_path = experts_path
    end

    description = "Skillpocket makes it easy for you to find and hire talented #{description_experts}."

    {
      title: title,
      title_text: title_text,
      description: description,
      experts: experts,
      category_path: category_path,
      city_path: city_path,
      all_cities_path: all_cities_path,
      category_path: category_path,
      all_categories_path: all_categories_path
    }
  end

  CATEGORIES = {
    "developers" => {
      title: "Programmers & Developers",
      name:  "developers",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "designers" => {
      title: "Business-experts",
      name: "designers",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "marketers" => {
      title: "Digital Marketeers & Sales Experts",
      name: "marketers",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "strategists" => {
      title: "Skills & Mangement Experts",
      name: "strategists",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "creatives" => {
      title: "UI/UX & Product Designers",
      name: "creatives",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    }
  }

  CITIES = {
    "new-york" => {
      latitude: 40.71427,
      longitude: -74.00597,
      title: "New York",
      name: "New York"
    },
    "san-diego" => {
      latitude: 32.7152778,
      longitude: -117.1563889,
      title: "San Diego",
      name: "San Diego"
    },
    "san-francisco" => {
      latitude: 37.77493,
      longitude: -122.41942,
      title: "San Francisco",
      name: "San Francisco"
    },
    "seattle" => {
      latitude: 47.60621,
      longitude: -122.33207,
      title: "Seattle",
      name: "Seattle"
    },
    "los-angeles" => {
      latitude: 34.05223,
      longitude: -118.24368,
      title: "Los Angeles",
      name: "Los Angeles"
    },
    "san-jose" => {
      latitude: 37.33939,
      longitude: -121.89496,
      title: "San Jose",
      name: "San Jose"
    }
  }
end
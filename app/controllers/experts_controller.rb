class ExpertsController < ApplicationController
  skip_before_action :authenticate!, only: [:index]

  def index
    state = get_city_and_category_state(params[:category], params[:city], User.approved.experts)

    @title = state[:title]
    @description = state[:description]

    @categories = CATEGORIES.map { |category_url, category| { name: category[:name], path: state[:category_path].call(category_url) } }
    @categories.unshift({ name: "All Categories", path: state[:all_categories_path] })

    @cities     = CITIES.map     { |city_url, city| { name: city[:name], path: state[:city_path].call(city_url) } }
    @cities.unshift({ name: "All Cities", path: state[:all_cities_path] })

    if current_user.present?
      @experts = state[:experts].by_rating(current_user)
    else
      @experts = state[:experts].by_authority
    end

    @experts = UserDecorator.decorate_collection(@experts)
  end

private

  # In heavy need for refactoring, if adding new features needs to be done in instant
  def get_city_and_category_state(category, city, experts)
    if category_data = CATEGORIES[category]
      description = category_data[:description]
      experts = experts.with_any_category(category_data[:name])

      if city_data = CITIES[city]
        title = "Hire #{category_data[:title]} in #{city_data[:title]}"
        experts = experts.near([city_data[:latitude], city_data[:longitude]], 48, units: :km)

        city_path = Proc.new { |city| category_city_experts_path(category: category, city: city) }
        all_cities_path = category_experts_path(category: category)
        category_path = Proc.new { |category| category_city_experts_path(category: category, city: city) }
        all_categories_path = category_experts_path(category: city)
      else
        title = "Hire #{category_data[:title]}"

        city_path = Proc.new { |city| category_city_experts_path(category: category, city: city) }
        all_cities_path = category_experts_path(category: category)
        category_path = Proc.new { |category| category_experts_path(category: category) }
        all_categories_path = experts_path
      end
    elsif (city_data = CITIES[category]) && (city = category)
      title = "Hire experts in #{city_data[:title]}"
      description = "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
      experts = experts.near([city_data[:latitude], city_data[:longitude]], 48, units: :km)
      
      city_path = Proc.new { |city| category_experts_path(category: city) }
      all_cities_path = experts_path
      category_path = Proc.new { |category| category_city_experts_path(category: category, city: city) }
      all_categories_path = category_experts_path(category: city)
    else
      title = "Hire experts"
      description = "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
      experts = experts

      city_path = Proc.new { |city| category_experts_path(category: city) }
      all_cities_path = experts_path
      category_path = Proc.new { |category| category_experts_path(category: category) }
      all_categories_path = experts_path
    end

    {
      title: title,
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
    "technology" => {
      title: "Freelance Programmers & Developers",
      name:  "Technology",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "business" => {
      title: "Freelance Business-experts",
      name: "Business",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "marketing-sales" => {
      title: "Digital Marketeers & Sales Experts",
      name: "Marketing",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "skills-management" => {
      title: "Skills & Mangement Experts",
      name: "Management",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "product-design" => {
      title: "Freelance UI/UX & Product Designers",
      name: "Design",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "funding" => {
      title: "Investors, Venture Capitalists (VC’s)",
      name: "Funding",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "photo-video" => {
      title: "Freelance Photographers & Video-Experts",
      name: "Photo",
      description: "Unsure if your business makes sense? Sit down with a seasoned VC and get feedback on your deck."
    },
    "writing" => {
      title: "Freelance Copywriters and Translators",
      name: "Writing",
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
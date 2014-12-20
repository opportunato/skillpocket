class ExpertsController < ApplicationController
  skip_before_action :authenticate!, only: [:index]

  #TODO Abomination, needs rewriting
  def index
    state = get_city_and_category_state(params[:category], params[:city], User.approved.experts.from_twitter)

    @title            = state[:title]
    @title_tag        = state[:title_tag]
    @description      = state[:description]
    @meta_description = state[:meta_description]

    @categories  = CATEGORIES.map { |category_url, category| { name: category[:name], path: state[:category_path].call(category_url) } }
    @categories.unshift({ name: "all professionals", path: state[:all_categories_path] })

    @cities      = CITIES.map     { |city_url, city| { name: city[:name], path: state[:city_path].call(city_url) } }
    @cities.unshift({ name: "all cities", path: state[:all_cities_path]})

    if current_user.present?
      @experts = state[:experts].by_rating_for_view(current_user)
    else
      @experts = state[:experts].by_authority
    end

    if request.path == '/'
      @experts = @experts.limit(10)
    end

    @is_current_user_expert = current_user.present? && current_user.expert?

    pagescript_params(
      title: @title,
      description: @description,
      experts: ActiveModel::ArraySerializer.new(@experts, each_serializer: ExpertSerializer),
      categories: @categories,
      cities: @cities,
      is_current_user_expert: @is_current_user_expert
    )
  end

private

  # In heavy need for refactoring, if adding new features needs to be done in instant
  def get_city_and_category_state(category, city, experts)
    title = "Hire digital professionals for tasks or advice"
    title_tag = "Skillpocket — Hire digital professionals for tasks or advice"
    description = "Skillpocket helps you find and hire talented professionals to help grow your business."
    meta_description = "Skillpocket is a marketplace of talented professionals that stand ready to assist you and your business."

    if category_data = CATEGORIES[category]
      experts = experts.with_any_new_category(category_data[:search_name])

      title = category_data[:title]
      title_tag = "Hire #{category_data[:title_tag]}"
      description = "#{category_data[:teaser]} Hire one of our talented #{category_data[:teaser_noun]}"
      meta_description = "Skillpocket makes it easy to contact and hire talented #{category_data[:meta_noun]}"

      if city_data = CITIES[city]
        title += " in #{city_data[:name]}"
        title_tag += " in #{city_data[:name]}"
        description += " in #{city_data[:name]}"
        meta_description += " in #{city_data[:name]} for advice or freelance."
        experts = experts.near([city_data[:latitude], city_data[:longitude]], 48, units: :km)

        city_path = Proc.new { |city| category_city_experts_path(category: category, city: city) }
        all_cities_path = category_experts_path(category: category)
        category_path = Proc.new { |category| category_city_experts_path(category: category, city: city) }
        all_categories_path = category_experts_path(category: city)
      else
        title_tag += " on Skillpocket"
        meta_description += " for advice or freelance."

        city_path = Proc.new { |city| category_city_experts_path(category: category, city: city) }
        all_cities_path = category_experts_path(category: category)
        category_path = Proc.new { |category| category_experts_path(category: category) }
        all_categories_path = experts_path
      end
    elsif (city_data = CITIES[category]) && (city = category)
      title += " in #{city_data[:name]}"
      title_tag += " in #{city_data[:name]}"
      meta_description += " in #{city_data[:name]} for advice or freelance."
      experts = experts.near([city_data[:latitude], city_data[:longitude]], 48, units: :km)
      
      city_path = Proc.new { |city| category_experts_path(category: city) }
      all_cities_path = experts_path
      category_path = Proc.new { |category| category_city_experts_path(category: category, city: city) }
      all_categories_path = category_experts_path(category: city)
    else
      experts = experts

      city_path = Proc.new { |city| category_experts_path(category: city) }
      all_cities_path = experts_path
      category_path = Proc.new { |category| category_experts_path(category: category) }
      all_categories_path = experts_path
    end

    {
      title_tag: title_tag,
      meta_description: meta_description,
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
    "developers" => {
      title: "Developers",
      title_tag: "Freelance Programmers & Developers",
      search_name:  "Developer",
      name: "developers",
      teaser: "Need a developer who is great at JavaScript, iOS, PHP or other languages?",
      teaser_noun: "programmers",
      meta_noun: "programmers and developers"
    },
    "designers" => {
      title: "Designers",
      title_tag: "Freelance UX / UI & Product-Designers",
      search_name: "Designer",
      name: "designers",
      teaser: "Need a new logo? Or want UX- or product-feedback?",
      teaser_noun: "designers",
      meta_noun: "UX/UI and Product-designers"
    },
    "marketers" => {
      title: "Marketers",
      title_tag: "Freelance Digital & Online Marketers",
      search_name: "Marketer",
      name: "marketers",
      teaser: "Get assistance on SEO, email-marketing or other marketing & sales tasks.",
      teaser_noun: "marketers",
      meta_noun: "digital marketers"
    },
    "business" => {
      title: "Business consultants",
      title_tag: "Freelance Business Consultants",
      search_name: "Business consultant",
      name: "business consultants",
      teaser: "Get advice on your business and how to grow it.",
      teaser_noun: "strategists",
      meta_noun: "strategists and business consultants"
    },
    "creatives" => {
      title: "Creatives",
      title_tag: "Freelance Creatives",
      search_name: "Creative",
      name: "creatives",
      teaser: "Get assistance with photo, video or other creative production tasks.",
      teaser_noun: "creatives",
      meta_noun: "creatives"
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
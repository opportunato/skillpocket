# @cjsx React.DOM

LinkList = require('modules/link_list')

ExpertsList = React.createClass

  getDescription: ->
    description = @state.description
    if @state.showUserText
      description = [
        description,
        <p>
          <a href="https://itunes.apple.com/us/app/skillpocket-hire-experts/id933547324?ls=1&mt=8" target="_blank">
          "iPhone App"</a> and <a href="onboarding/step/1" target="_blank">apply to become an expert</a>
        </p>
      ]

    description

  syncData: (url) ->
    $.ajax
      url: url
      dataType: "json"
      cache: false
      .done (data) ->
        @setState
          description: data.description
          title: data.title
          categories: data.categories
          cities: data.cities
          experts: data.experts

  onCategoryChange: (value) ->
    @syncData(value)

  onCityChange: (value) ->
    @syncData(value)

  getInitialState: (props) ->
    description: @props.description
    title: @props.title
    categories: @props.categories
    cities: @props.cities
    experts: @props.experts
    showUserText: @props.showUserText

  currentCityIndex: ->
    @state.cities.reduce((memo, city, index) ->
      if window.location.pathname == city.path then index else memo
    , 0)

  currentCategoryIndex: ->
    @state.categories.reduce((memo, category, index) ->
      if window.location.pathname == category.path then index else memo
    , 0)

  render: ->
    <section className="experts-list">
      <h1>{@state.title}</h1>
      <p className="description">{@state.description}</p>
      <nav>
        Show 
        <LinkList 
          options={@state.categories}
          selectedIndex={@currentCategoryIndex()}
          onOptionClick={@onCategoryChange} /> in  
        <LinkList 
          options={@state.cities}
          selectedIndex={@currentCityIndex()}
          onOptionClick={@onCityChange} />
      </nav>
      <ul>
        {
          @state.experts.map (expert) ->
            <li className="expert" key={expert.id}>
              <a href={expert.path}>
                <div className="userpic"
                     style={backgroundImage: "url(#{expert.photo_url})", backgroundSize: "cover"}></div>
                <h4 className="name">{expert.full_name}</h4>
                <p className="job">{expert.job}</p>
                <div className="price">{expert.price}</div>
                <div style={backgroundImage: "url(#{expert.profile_banner_url})", backgroundSize: "cover"}></div>
                {expert.skill_title}
              </a>
            </li>
        }
      </ul>
    </section>

module.exports = ExpertsList
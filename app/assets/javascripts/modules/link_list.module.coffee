# @cjsx React.DOM

cx = React.addons.classSet

LinkList = React.createClass

  renderOption: (option, index) ->
    <li key={option.name}>
      <a href={option.path} 
         onClick={@onOptionClick}
         dataIndex={index}>{option.name}</a>
    </li>

  propTypes:
    options: React.PropTypes.array.isRequired
    selectedIndex: React.PropTypes.number
    onOptionClick: React.PropTypes.func

  getDefaultProps: ->
    onOptionClick: ->

  onOptionClick: (event) ->
    # event.preventDefault()
    # @setState
    #   selectedIndex: $(event.target).data(index)

    # @props.onOptionClick(event.target.getAttribute("href"))

  onDocumentClick: (event) ->
    if @state.opened
      @setState
        opened: false

  componentWillMount: ->
    document.body.addEventListener "click", @onDocumentClick

  componentWillUnmount: ->
    document.body.removeEventListener "click", @onDocumentClick

  onButtonClick: ->
    @setState
      opened: true

  getInitialState: ->
    opened: false
    selectedIndex: @props.selectedIndex || 0

  render: ->
    selectedOption = @props.options[@state.selectedIndex]

    classes = cx({
      "link-list": true,
      opened: @state.opened
    })

    <div className={classes}>
      <button className="anchorlike" onClick={@onButtonClick}>
        {selectedOption.name}
      </button>
      <ul>
        {
          @props.options.map (option, index) =>
            @renderOption(option, index)
        }
      </ul>
    </div>

module.exports = LinkList
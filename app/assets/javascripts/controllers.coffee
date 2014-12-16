@['experts#index'] = (data) ->
  ExpertsList = require('modules/experts_list')

  expertsList = React.createFactory(ExpertsList)

  React.render(
    expertsList({
      title: data.title,
      description: data.description,
      categories: data.categories,
      cities: data.cities,
      experts: data.experts,
      showUserText: data.is_current_user_expert
    }),
    document.querySelector('body > main')
  )
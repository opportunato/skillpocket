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

@["users#show"] = ->
  $popup = $(".message-popup")
  $form  = $(".message-form")

  $(".message-button").on "click", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(document.body).addClass("no-scroll")
    $popup.addClass("active")

  $(document).on "click", (e) ->
    if $(e.target).parents(".message-popup").length == 0
      $popup.removeClass("active")
      $(document.body).removeClass("no-scroll")

  $form.find('.form-group > input, textarea').on 'focus', (e) ->
    $(e.target).parents('.form-group').removeClass('has-error')
    $(e.target).siblings('span.help-block').remove()

  $form.on "submit", (e) ->
    e.preventDefault()

    formData = $(e.target).serialize()

    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    $email = $form.find(".web_message_email")
    $body  = $form.find(".web_message_body")
    $name  = $form.find(".web_message_full_name")

    emailVal = $email.find("input").val()
    bodyVal  = $body.find("textarea").val()
    nameVal  = $name.find("input").val()

    errors = 0

    if emailVal.length == 0 || !re.test(emailVal)
      errors += 1
      $email.addClass("has-error")
      $email.find('span.help-block').remove()
      $email.append("<span class='help-block'>Enter valid email, please</div>")

    if nameVal.length == 0
      errors += 1
      $name.addClass("has-error")
      $name.find('span.help-block').remove()
      $name.append("<span class='help-block'>Enter your full name, please</div>")

    if bodyVal.length == 0
      errors += 1
      $body.addClass("has-error")
      $body.find('span.help-block').remove()
      $body.append("<span class='help-block'>Enter your message, please</div>")

    if errors == 0
      $form.find('input[type="submit"]').prop('disabled', true)
      $.post "/web_messages", formData, (data) ->
        $('.message-popup .wrapper').html(
          "<h2>Message successfully sent! Wait for expert reply!</h2>
          <p>Meanwhile, you can look for more awesome experts <a href='/experts'>here</a>.</p>"
        )
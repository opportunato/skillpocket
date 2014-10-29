SimpleForm.setup do |config|
  config.wrappers :default, class: :input,
    hint_class: :hints, error_class: :errors do |b|

    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.wrappers :checkbox, tag: :div, class: "checkbox", error_class: "has-error" do |b|

    b.use :html5

    b.wrapper tag: :div do |ba|
      ba.use :input
      ba.use :label_text, wrap_with: { tag: :span }
    end

    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = 'btn'
  config.error_method = :first

  config.error_notification_tag = :span
  config.error_notification_class = 'error_notification'

  config.browser_validations = false
  config.boolean_label_class = 'checkbox'
end

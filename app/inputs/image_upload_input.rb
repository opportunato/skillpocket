class ImageUploadInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    image_url = @builder.object.send(attribute_name)

    template.content_tag :div, input_html_options.merge({style: "background-image: url(#{image_url});"}) do
      @builder.file_field(attribute_name)
    end
  end
end
class CollectionTextInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    tags = @builder.object.send(attribute_name)
    tags_string = tags.non_categories.reduce do |string, tag|
      string + ", " + tag.name 
    end

    @builder.text_field(attribute_name, value: tags_string)
  end
end
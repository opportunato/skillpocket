json.title @title
json.description @description
json.experts ActiveModel::ArraySerializer.new(@experts, each_serializer: ExpertSerializer)
json.categories @categories
json.cities @cities
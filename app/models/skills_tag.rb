class SkillsTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :skill
end
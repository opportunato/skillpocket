class SkillCreator
  attr_reader :skill

  def initialize(user)
    @user = user
  end

  def create(skill_params)
    @skill = @user.skill || Skill.new

    if @skill.update(skill_params.merge({ user_id: @user.id }))
      tags = @skill.tags_text.split(',')
      categories = @skill.categories_list
      tags = tags + categories
    end

    @skill.persisted? && @skill.valid? && @skill.update_tags(*tags)
  end
end
class SkillCreator
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

  def self.perform(user, skill_params)
    self.new(user).create(skill_params)
  end
end
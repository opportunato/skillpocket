module ApplicationHelper
  def expert_title(expert)
    "#{expert.full_name} - #{expert.skill_title}"
  end  

  def full_url(path)
    request.protocol + request.host + path
  end
end

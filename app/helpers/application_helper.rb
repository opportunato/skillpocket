module ApplicationHelper
  def expert_title(expert)
    "#{expert['full_name']} - #{expert['skill_title']}"
  end  
end

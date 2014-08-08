module ApplicationHelper
  def expert_title(expert)
    "#{expert['full_name']} - #{expert['skill_title']}"
  end  

  def strip_protocol(s)
    s.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end
end

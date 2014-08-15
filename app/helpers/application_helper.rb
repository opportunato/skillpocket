module ApplicationHelper
  def expert_title(expert)
    "#{expert['full_name']} - #{expert['skill_title']}"
  end  

  def strip_protocol(s)
    s.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def expert_categories(expert)
    expert['categories'] ||= []
    expert['categories'].map { |category| category['id'] }.join(',')
  end
end

module ApplicationHelper
  def expert_title(expert)
    "#{expert.full_name} - #{expert.skill_title}"
  end  

  def full_url(path)
    request.protocol + request.host + path
  end

  def link_active_unless_current name, options = {}, html_options = {}
    link_to_unless_current name, options, html_options do
      content_tag :span, name, class: "active"
    end
  end
end

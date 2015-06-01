module ApplicationHelper

  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def classifications_nav
    html = ""
    groups = Classification.all.group_by { |c| c.content_type.name }
    groups.each do |content_type, group|
      html += "<li class='mt2'><a class='block button button-transparent blue' href='/documents?content_type=#{content_type}'>#{content_type.titleize}</a></li>"
      group.sort_by(&:name).each do |classification|
        html += "<li><a class='button block button-transparent' href='/documents?classification_id=#{classification.id}'>#{classification.name.titleize} (#{classification.documents_count})</a></li>"
      end
    end
    html.html_safe
  end
end

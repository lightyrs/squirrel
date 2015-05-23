module ApplicationHelper

  def classifications_nav
    html = ""
    groups = Classification.all.group_by { |c| c.content_type.name }
    groups.each do |content_type, group|
      html += "<li class='content-type mt1'><strong>#{content_type.titleize}</strong></li>"
      group.each do |classification|
        html += "<li><a href='/documents?classification_id=#{classification.id}'>#{classification.name.titleize}</a></li>"
      end
    end
    html.html_safe
  end
end

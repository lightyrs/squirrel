module DocumentsHelper

  def description(document)
    if document.description && document.description.length >= 25
      truncate(document.description, length: 300)
    else
      truncate(document.body, length: 300)
    end
  end

  def classification_tags(document)
    html = <<-eos
      <span class='inline-block px1 white bg-red rounded'>#{document.classification_name}</span>
      <span class='inline-block px1 white bg-red rounded'>#{document.content_type_name}</span>
    eos
    html.html_safe
  end
end

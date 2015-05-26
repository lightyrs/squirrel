class ListDocuments < ActiveInteraction::Base

  hash :params, strip: false

  def execute
    docs = if params[:classification_id].present?
      crumb = Classification.find(params[:classification_id]).name.titleize rescue nil
      Document.where(classification_id: params[:classification_id])
    elsif params[:content_type].present?
      crumb = params[:content_type].titleize rescue nil
      content_type = ContentType.find_by(name: params[:content_type])
      Document.where(classification_id: content_type.classifications.pluck(:id))
    elsif params[:sitename].present?
      crumb = params[:sitename]
      Document.where(sitename: params[:sitename])
    else
      crumb = "All"
      Document
    end

    {
      crumb: crumb,
      documents: docs.order("created_at DESC").includes(classification: [:content_type]).page(params[:page])
    }
  end
end

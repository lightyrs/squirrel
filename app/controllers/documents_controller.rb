class DocumentsController < ApplicationController

  breadcrumb 'Documents', :documents_path

  def index
    docs = if params[:classification_id].present?
      @crumb = Classification.find(params[:classification_id]).name.titleize rescue nil
      Document.where(classification_id: params[:classification_id])
    elsif params[:content_type].present?
      @crumb = params[:content_type].titleize rescue nil
      content_type = ContentType.find_by(name: params[:content_type])
      Document.where(classification_id: content_type.classifications.pluck(:id))
    else
      @crumb = "All"
      Document
    end

    @documents = docs.order("created_at DESC").includes(classification: [:content_type]).page(params[:page])
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    breadcrumb 'New', new_document_path, force: true
    @document = CreateDocument.new
  end

  def create
    outcome = CreateDocument.run(params.fetch(:document, {}))

    if outcome.valid?
      redirect_to outcome.result
    else
      breadcrumb 'New', new_document_path, force: true
      @document = outcome
      render :new
    end
  end
end

class DocumentsController < ApplicationController

  def index
    docs = if params[:classification_id].present?
      @heading = Classification.find(params[:classification_id]).name.titleize rescue nil
      Document.where(classification_id: params[:classification_id])
    elsif params[:content_type].present?
      @heading = params[:content_type].titleize rescue nil
      content_type = ContentType.find_by(name: params[:content_type])
      Document.where(classification_id: content_type.classifications.pluck(:id))
    else
      @heading = nil
      Document
    end

    @documents = docs.order("created_at DESC").includes(classification: [:content_type]).page(params[:page])
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = CreateDocument.new
  end

  def create
    outcome = CreateDocument.run(params.fetch(:document, {}))

    if outcome.valid?
      redirect_to outcome.result
    else
      @document = outcome
      render :new
    end
  end
end

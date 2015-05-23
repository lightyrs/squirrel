class DocumentsController < ApplicationController

  def index
    docs = Document.where(classification_id: params[:classification_id])
    docs.rewhere(classification_id: nil) unless params[:classification_id].present?

    @documents = docs.order("created_at DESC").includes(classification: [:content_type]).page(params[:page])
  end

  def show
    @document = Document.find(params[:id])
  end
end

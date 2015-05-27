class DocumentsController < ApplicationController

  breadcrumb 'Documents', :documents_path

  def index
    outcome = ListDocuments.run(params: params)

    @crumb     = outcome.result[:crumb]
    @documents = outcome.result[:documents]
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    breadcrumb 'New', new_document_path, force: true
    @batch = params[:batch]
    @document = CreateDocument.new
  end

  def create
    if document_params[:urls] && document_params[:urls].present?
      document_params[:urls].lines.map(&:chomp).each do |url|
        CreateDocumentWorker.perform_async(url, document_params[:classification])
      end

      redirect_to documents_path
    else
      outcome = CreateDocument.run(document_params)

      if outcome.valid?
        redirect_to outcome.result
      else
        breadcrumb 'New', new_document_path, force: true
        @document = outcome
        render :new
      end
    end
  end

  private

  def document_params
    params.fetch(:document, {})
  end
end

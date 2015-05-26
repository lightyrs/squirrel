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

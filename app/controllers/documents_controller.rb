class DocumentsController < ApplicationController

  def index
    @documents =  Document.order("created_at DESC").includes(classification: [:content_type]).limit(100)
  end

  def show
    @document = Document.find(params[:id])
  end
end

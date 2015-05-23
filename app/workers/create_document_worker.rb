class CreateDocumentWorker
  include Sidekiq::Worker

  def perform(url:, content_type:, classification:)
    CreateDocument.run!(url: url, content_type: content_type, classification: classification)
  end
end

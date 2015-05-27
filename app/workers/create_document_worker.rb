class CreateDocumentWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  sidekiq_retry_in do |count|
    30 * (count + 1) # (i.e. 30, 60, 90, 120)
  end

  def perform(url:, content_type:, classification:)
    CreateDocument.run!(url: url, content_type: content_type, classification: classification)
  end
end

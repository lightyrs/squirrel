class CreateDocumentWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  sidekiq_retry_in do |count|
    30 * (count + 1) # (i.e. 30, 60, 90, 120)
  end

  def perform(url, classification_id)
    Chewy.strategy(:sidekiq) do
      CreateDocument.run!(url: url, classification: classification_id)
    end
  end
end

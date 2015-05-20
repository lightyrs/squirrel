class CreateDocument < ActiveInteraction::Base

  string    :url, :content_type, :classification
  validates :url, :content_type, :classification, presence: true

  def execute
    content_type_model    = ContentType.find_by(name: content_type)
    classification_model  = Classification.where(
                              name: classification,
                              content_type_id: content_type_model.id
                            ).try(:first)

    if classification_model.nil?
      document = nil
    else
      document = Document.create(url: url, classification_id: classification_model.id)
    end

    document
  end
end

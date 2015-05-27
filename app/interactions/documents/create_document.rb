class CreateDocument < ActiveInteraction::Base

  array     :urls, default: []

  string    :url, :classification
  validates :url, :classification, presence: true

  def to_model
    Document.new
  end

  def execute
    document = Document.new(url: url, classification_id: classification)

    unless document.save
      errors.merge!(document.errors)
    end

    document
  end
end

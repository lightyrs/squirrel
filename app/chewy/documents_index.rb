class DocumentsIndex < Chewy::Index

  settings analysis: {
    analyzer: {
      squirrel: {
        type: 'standard',
        stopwords: STOP_WORDS
      }
    }
  }

  define_type Document.includes(:classification) do
    field :url, index: "not_analyzed"
    field :best_image_url, include_in_all: false, index: "not_analyzed"
    field :favicon_url, include_in_all: false, index: "not_analyzed"
    field :author, index: "not_analyzed"
    field :content_type_header, include_in_all: false, index: "not_analyzed"
    field :charset, include_in_all: false, index: "not_analyzed"
    field :og_type, include_in_all: false, index: "not_analyzed"
    field :keywords, boost: 5.0, analyzer: 'squirrel'
    field :title, boost: 10.0, analyzer: 'squirrel'
    field :description, boost: 10.0, analyzer: 'squirrel'
    field :body, analyzer: 'squirrel'
    field :body_html, include_in_all: false, index: "no"
    field :classification do
      field :name, index: "not_analyzed"
      field :content_type, index: "not_analyzed", value: -> (classification) { classification.content_type.name }
    end
    field :created, type: 'date', include_in_all: false, value: -> { created_at }
  end
end

class DocumentsIndex < Chewy::Index

  define_type Document.includes(:classification) do
    field :url
    field :best_image_url, include_in_all: false
    field :favicon_url, include_in_all: false
    field :author
    field :content_type_header, include_in_all: false
    field :charset, include_in_all: false
    field :og_type, include_in_all: false
    field :keywords
    field :title, analyzer: 'snowball'
    field :description, analyzer: 'snowball'
    field :body, analyzer: 'snowball'
    field :body_html, include_in_all: false
    field :classification do
      field :name
      field :content_type, value: -> (classification) { classification.content_type.name }
    end
    field :created, type: 'date', include_in_all: false, value: -> { created_at }
  end
end

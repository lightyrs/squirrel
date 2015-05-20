class DocumentsIndex < Chewy::Index

  define_type Document.includes(:classification) do
    field :url, :best_image_url, :favicon_url
    field :author, :content_type_header, :charset, :og_type
    field :keywords
    field :title, :description
    field :body, :body_html
    field :classification do
      field :name
      field :content_type, value: -> (classification) { classification.content_type.name }
    end
    field :created, type: 'date', include_in_all: false, value: -> { created_at }
  end
end

class FetchDocument < ActiveInteraction::Base

  object :document

  def execute
    if doc = Pismo::Document.new(document.url) && page = MetaInspector.new(document.url)

      if doc.body.bytesize <= 3000
        doc = Pismo::Document.new(document.url, reader: :cluster)
      end

      if doc.body.bytesize <= 3000
        puts "Invalid Document.".red
      else
        puts doc.title.inspect.green

        document.url                 = (page.url || document.url) rescue document.url
        document.title               = (page.best_title || doc.title) rescue doc.title
        document.description         = (page.description || doc.description) rescue doc.description
        document.best_image_url      = page.images.best rescue ''
        document.favicon_url         = page.images.favicon rescue ''
        document.author              = page.meta['author'] rescue ''
        document.keywords            = page.meta['keywords'].try(:split, ',') rescue []
        document.charset             = page.charset rescue ''
        document.og_type             = page.meta['og:type'] rescue ''
        document.content_type_header = page.content_type rescue ''
        document.body                = doc.body
        document.body_html           = doc.body_html
      end
    end
  end
end

class Gatherer

  def self.download_and_save_url(url, classification:, medium:)
    if doc = Pismo::Document.new(url) && page = MetaInspector.new(url)

      if doc.body.bytesize <= 3000
        doc = Pismo::Document.new(url, reader: :cluster)
      end

      if doc.body.bytesize <= 3000
        puts "Invalid Document.".red
      else
        puts doc.title.inspect.green

        # Document.create(
        #   url: (page.url || url) rescue url,
        #   title: (page.best_title || doc.title) rescue doc.title,
        #   description: (page.description || doc.description) rescue doc.description,
        #   best_image_url: page.images.best rescue '',
        #   favicon_url: page.images.favicon rescue '',
        #   author: page.meta['author'] rescue '',
        #   keywords: page.meta['keywords'].try(:split, ',') rescue [],
        #   charset: page.charset rescue '',
        #   og_type: page.meta['og:type'] rescue '',
        #   content_type_header: page.content_type rescue ''
        # )
      end
    end
  end
end

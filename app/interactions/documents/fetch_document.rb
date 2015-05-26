class FetchDocument < ActiveInteraction::Base

  object :document

  def execute
    if @doc = Pismo::Document.new(document.url)

      @page = MetaInspector.new(document.url)

      if document.persisted?
        refresh_attributes
      else
        if @doc.body.bytesize <= 3000
          @doc = Pismo::Document.new(document.url, reader: :cluster)
        end

        if @doc.body.bytesize <= 3000
          puts "Invalid Document.".red
        else
          assign_attributes
        end
      end
    end
  end

  def assign_attributes
    puts @doc.title.inspect.green

    document.tap do |d|
      d.sitename            = assign_sitename
      d.favicon_url         = assign_favicon_url
      d.url                 = assign_url
      d.title               = assign_title
      d.description         = assign_description
      d.best_image_url      = @page.images.best rescue ''
      d.author              = @page.meta['author'] rescue ''
      d.keywords            = @page.meta['keywords'].try(:split, ',') rescue []
      d.charset             = @page.charset rescue ''
      d.og_type             = @page.meta['og:type'] rescue ''
      d.content_type_header = @page.content_type rescue ''
      d.body                = @doc.body
      d.body_html           = @doc.html_body
    end
  end

  def refresh_attributes
    puts @doc.title.inspect.green

    document.tap do |d|
      d.sitename    = assign_sitename
      d.favicon_url = assign_favicon_url
    end
  end

  def assign_sitename
    return @page.meta["og:site_name"] if @page.meta.keys.include?("og:site_name")
    return @page.meta["twitter:domain"] if @page.meta.keys.include?("twitter:domain")
    return @doc.sitename if @doc.sitename && @doc.sitename.present?
    return @page.host if @page.host && @page.host.present?
    return PublicSuffix.parse(document.url).domain
  rescue => e
    puts "#{e.class}: #{e.message}".red
    PublicSuffix.parse(document.url).domain
  end

  def assign_favicon_url
    return @page.images.favicon if @page.images.favicon && @page.images.favicon.present?
    return @doc.favicon if @doc.favicon && @doc.favicon.present?
  rescue => e
    puts "#{e.class}: #{e.message}".red
    @doc.favicon if @doc.favicon && @doc.favicon.present?
  end

  def assign_url
    return @page.url if @page.url && @page.url.present?
    return document.url
  rescue => e
    puts "#{e.class}: #{e.message}".red
    document.url
  end

  def assign_title
    return @doc.title if @doc.title && @doc.title.present?
    return @page.best_title if @page.best_title && @page.best_title.present?
  rescue => e
    puts "#{e.class}: #{e.message}".red
    @page.title
  end

  def assign_description
    return @page.description if @page.description && @page.description.present?
    return @doc.description if @doc.description && @doc.description.present?
  rescue => e
    puts "#{e.class}: #{e.message}".red
    @doc.description
  end
end

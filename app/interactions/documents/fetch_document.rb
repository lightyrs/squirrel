class FetchDocument < ActiveInteraction::Base

  object :document

  def execute
    py_doc = `python extractor.py #{document.url}` rescue "{}"

    if @doc = Oj.load(py_doc).to_properties

      @pismo_doc = Pismo::Document.new(document.url) rescue {body: "", description: "", html_body: ""}

      if @pismo_doc.body.bytesize <= document.classification.min_bytesize
        @pismo_doc = Pismo::Document.new(document.url, reader: :cluster)
      end

      if @pismo_doc.body.bytesize <= document.classification.min_bytesize
        puts "Invalid Document".red
      end

      @page = MetaInspector.new(document.url) rescue nil

      if document.persisted?
        refresh_attributes
      else
        assign_attributes
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
      d.best_image_url      = @page.images.best rescue @doc.top_image
      d.author              = @page.meta['author'] rescue @doc.author
      d.keywords            = @doc.keywords || @page.meta['keywords'].try(:split, ',') rescue []
      d.charset             = @page.charset rescue ''
      d.og_type             = @page.meta['og:type'] rescue ''
      d.content_type_header = @page.content_type rescue ''
      d.body                = @doc.body
      d.body_html           = assign_body_html
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
    return PublicSuffix.parse(document.url).domain.gsub(/^www\./, "")
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
    return @pismo_doc.description if @pismo_doc.description && @pismo_doc.description.present?
    return @page.description if @page.description && @page.description.present?
    return @doc.description if @doc.description && @doc.description.present?
  rescue => e
    puts "#{e.class}: #{e.message}".red
    @doc.description
  end

  def assign_body_html
    if @doc.html_body && @doc.html_body.bytesize > 500
      @doc.html_body
    else
      @pismo_doc.html_body
    end
  rescue => e
    puts "#{e.class}: #{e.message}".red
  end
end

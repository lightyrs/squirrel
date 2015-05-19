class Gatherer

  def self.download_and_save_url(url, classification:, medium:)
    if doc = Pismo::Document.new(url)

      if doc.body.bytesize <= 3000
        doc = Pismo::Document.new(url, reader: :cluster)
      end

      if doc.body.bytesize <= 3000
        puts "Couldn't read document.".red
      else
        puts doc.title.inspect.green

        filename = "#{Rails.root}/data/#{classification.parameterize}/#{medium.parameterize}/#{doc.title.parameterize}.txt"
        if File.exist?(filename)
          filename = increment_path(filename)
        end

        File.open(filename, File::CREAT | File::EXCL | File::WRONLY) do |file|
          file.puts doc.body
        end

        filename = "#{Rails.root}/data/#{classification.parameterize}/#{medium.parameterize}/#{doc.title.parameterize}.html"
        if File.exist?(filename)
          filename = increment_path(filename)
        end

        File.open(filename, File::CREAT | File::EXCL | File::WRONLY) do |file|
          file.puts doc.html_body
        end
      end
    end
  end

  private

  def self.increment_path(path)
    _, filename, count, extension = *path.match(/(\A.*?)(?:_#(\d+))?(\.[^.]*)?\Z/)
    count = (count || '0').to_i + 1
    "#{filename}_##{count}#{extension}"
  end
end

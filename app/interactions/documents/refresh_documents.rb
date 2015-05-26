class RefreshDocuments < ActiveInteraction::Base

  def execute
    Document.find_each do |document|
      begin
        outcome = FetchDocument.run(document: document)
        if outcome.valid?
          outcome.result.save
        end
      rescue => e
        puts "#{e.class}: #{e.message}".red
      end
    end
  end
end

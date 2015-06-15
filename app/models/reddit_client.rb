class RedditClient

  attr_reader :client

  def initialize
    @client = Redd.it(:userless, REDDIT[:client_id], REDDIT[:secret])
  end
end

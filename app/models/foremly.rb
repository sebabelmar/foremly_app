module Foremly

  class Transactions
    include HTTParty
    base_uri 'http://localhost:9393'

    def initialize(service, page)
      @options = { query: {site: service, page: page} }
    end

    def cardholder_transactions(card_number)
      response = self.class.get("/card/#{card_number}", @options)
      return response.body
    end

  end
end
module Foremly
  class Transaction
    include HTTParty
    base_uri 'http://localhost:9999'

    def initialize(service, page)
      @options = { query: {site: service, page: page} }
    end

    def cardholder_transactions(card_number)
      response = self.class.get("/transactionss/#{card_number}", @options)
      return response.body
    end

    def all_transactions
      response = self.class.get("/all", @options)
      return response.body
    end

  end
end
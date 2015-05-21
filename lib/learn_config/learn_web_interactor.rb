require 'faraday'
require 'oj'

module LearnConfig
  class LearnWebInteractor
    attr_reader :token, :conn

    LEARN_URL = 'https://learn.co'
    API_ROOT  = '/api/v1'

    def initialize(token)
      @token = token
      @conn = Faraday.new(url: LEARN_URL) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def me_endpoint
      "#{API_ROOT}/users/me"
    end

    def me
      response = @conn.get do |req|
        req.url me_endpoint
        req.headers['Authorization'] = "Bearer #{token}"
      end
      puts response
      puts response.status
      puts response.body

      Oj.load(response, symbol_keys: true)
    end
  end
end

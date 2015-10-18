require 'rest-client'
require 'logger'

class FyberApi
  def initialize
    @logger = Logger.new(STDOUT)
  end

  def offers(req)
    url = req.to_url
    @logger.info("Request to Fyber API: #{url}")
    resp = RestClient.get url
    ApiResponse.new(resp)
  end
end
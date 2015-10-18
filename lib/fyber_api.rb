require 'rest-client'

class FyberApi

  def offers(req)
    resp = RestClient.get req.to_url
    ApiResponse.new(resp)
  end
end
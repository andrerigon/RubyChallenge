require 'digest/sha1'

class Offer
  attr_reader :id, :title, :thumbnail_lowres, :payout

  def initialize(id, title, thumbnail_lowres, payout)
    @id = id
    @title = title
    @thumbnail_lowres = thumbnail_lowres
    @payout = payout

  end
end

class ApiResponse
  include APIConfig

  attr_reader :offers

  def initialize(http_response)
    raise RuntimeError, 'invalid API response' unless valid?(http_response)

    json = JSON.parse(http_response.body)
    @count = json.fetch('count', 0)
    @offers =  parse_offers(json)
  end

  def parse_offers(json)
    json.fetch('offers', []).map { |o|
      Offer.new(o['id'], o['title'], o['thumbnail']['lowres'], o['payout'])
    }
  end

  def valid?(http_response)
    hash = Digest::SHA1.hexdigest(http_response.body + api_key)
    hash == http_response.headers[:'x_sponsorpay_response_signature']
  end


  def has_results?
    @count > 0
  end
end


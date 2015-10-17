require 'digest/sha1'

module APIConfig

  def defaults
    {
        :appid => 157,
        :device_id => '2b6f0cc904d137be2e1730235f5664094b83',
        :format =>'json',
        :ip => '109.235.143.113',
        :locale => 'de',
        :offer_types => 112
    }
  end

  def timestamp
    Time.now.getutc.to_i
  end

  def api_key
    'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
  end

  def api_uri
    'http://api.fyber.com/feed/v1/offers.json'
  end
end

class FyberRequest
  include APIConfig

  def initialize(uid, pub0, page)
    @config = defaults.merge({
        :uid => uid,
        :pub0 => pub0,
        :page => page
    })
  end

  def to_url
    options = @config.merge(:timestamp => timestamp).sort.map { |k, v| "#{k}=#{v}" }.join('&')
    hash = generate_hash(options)
    "#{api_uri}?#{options}&hashkey=#{hash}".to_s
  end

  def generate_hash(options)
    Digest::SHA1.hexdigest options + "&" + api_key
  end
end

class FyberResponse
  include APIConfig

  def initialize(http_response)
    raise RuntimeError, 'invalid API response' unless valid?(http_response)
  end

  def valid?(http_response)
    hash = Digest::SHA1.hexdigest(http_response.body + api_key)
    hash == http_response.headers[:'X-Sponsorpay-Response-Signature']
  end




end
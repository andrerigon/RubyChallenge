require 'digest/sha1'

class ApiRequest
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
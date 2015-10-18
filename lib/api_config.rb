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
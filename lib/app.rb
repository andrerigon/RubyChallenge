require 'sinatra'
require 'logger'

class App < Sinatra::Base

  configure do
    set :api, :: FyberApi.new
    set :views, settings.root + '/../views'
    enable :logging
  end

  get '/' do
    erb :index
  end

  post '/' do
    req = ApiRequest.new(params['uid'], params['pub0'], params['page'])
    begin
      render_offers(settings.api.offers(req))
    rescue => ex
      logger.error('Error when fetching offers: ' + ex.to_s)
      'No offers available'
    end

  end

  def render_offers(resp)
    if resp.has_results?
      erb :offers, :locals => {:offers => resp.offers}
    else
      logger.info('No offers found')
      'No offers available'
    end
  end
end

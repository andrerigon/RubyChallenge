require 'sinatra'

class App < Sinatra::Base

  configure do
    set :api, :: FyberApi.new
    set :views, settings.root + '/../views'
  end

  get '/' do
    erb :index
  end

  post '/' do
    req = ApiRequest.new(params['uid'], params['pub0'], params['page'])
    resp = settings.api.offers(req)
    if resp.has_results?
      erb :offers, :locals => {:offers => resp.offers}
    else
      'No offers available'
    end
  end


end

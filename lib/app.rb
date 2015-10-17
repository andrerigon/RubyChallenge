require 'sinatra'

class App  < Sinatra::Base

  get '/fyber' do
    'hi!'
  end

end

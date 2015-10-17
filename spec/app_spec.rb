require 'app'

RSpec.describe App, '#foo' do
   context 'ctx' do
     it 'bar' do
       get '/fyber'
       expect(last_response.body).to eq('hi!')
     end
   end
end
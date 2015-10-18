RSpec.describe App, '#foo' do


  let(:resp) {
    double('api response')
  }

  class MockApi
    def initialize(resp)
      @resp = resp
    end
    def offers(req)
      @resp
    end
  end

  let(:api) { MockApi.new(resp) }

  before do
    App.set :api, api
  end

   context 'rendering index' do
     it 'render index' do
       get '/'
       expect(last_response.body).to include('form')
     end
   end

   context 'posting request' do
     it 'render error msg if no results' do
       allow(resp).to receive(:has_results?) {false}
       post '/'
       expect(last_response.body).to include('No offers available')
     end

     it 'render offers' do
       allow(resp).to receive(:has_results?) {true}
       allow(resp).to receive(:offers) { [Offer.new('id', 'awesome title', 'http://cdn3.sponsorpay.com/assets/38646/Screen_Shot_2013-12-10_at_3.36.25_PM_square_60.png', 123)] }
       post '/'
       expect(last_response.status).to be(200)
       expect(last_response.body).to include('awesome title')
     end
   end
end
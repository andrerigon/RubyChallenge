require 'model'
require 'spec_helper'


RSpec.describe 'models', '#to_url' do
    describe "FyberRequest" do
      let(:subject) {
        FyberRequest.new('andre', 'spec', 1)
      }

      it 'generates correct url' do
        timestamp = 1445118414
        expected = 'http://api.fyber.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&format=json&ip=109.235.143.113&locale=de&offer_types=112&page=1&pub0=spec&timestamp=1445118414&uid=andre&hashkey=bad32594419cccdd84771ee410969d2b66262692'
        allow_any_instance_of(APIConfig).to receive(:timestamp).and_return(timestamp)
        expect(subject.to_url).to eq(expected)
      end

      it 'creates timestamp' do
        timestamp = Time.now.getutc.to_i
        expect(subject.timestamp).to be >= timestamp
      end
    end

    describe "FyberResponse" do

      it 'verifies correct response' do
        http_response = double('http response')
        allow(http_response).to receive(:body) { '{"foo" : "bar"}' }
        allow(http_response).to receive(:headers) do
          hash = Digest::SHA1.hexdigest(http_response.body + 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f')
          {:'X-Sponsorpay-Response-Signature' => hash }
        end
      end

      it 'throw exception for invalid response' do
        http_response = double('http response')
        allow(http_response).to receive(:body) { '{"foo" : "bar"}' }
        allow(http_response).to receive(:headers) do
          hash = Digest::SHA1.hexdigest(http_response.body + 'wrong key')
          {:'X-Sponsorpay-Response-Signature' => hash }
        end

        expect { FyberResponse.new(http_response) }.to raise_error(RuntimeError, 'invalid API response')
      end

    end

end




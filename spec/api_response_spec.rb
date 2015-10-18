require 'spec_helper'


RSpec.describe 'ApiResponse' do

      context 'signed response' do
        it 'verifies correct response' do
          expect { ApiResponse.new(mock_http) }.to_not raise_error 
        end

        it 'throw exception for invalid response' do
          expect { ApiResponse.new(mock_http(hash: 'wrong')) }.to raise_error(RuntimeError, 'invalid API response')
        end
      end

      context 'response results' do
        it 'returns false if does not have results' do
          resp = ApiResponse.new(mock_http(body: '{ "count" : 0 }'))
          expect(resp.has_results?).to be_falsey
        end

        it 'returns true if there are results' do
          resp = ApiResponse.new(mock_http(body: '{ "count" : 20 }'))
          expect(resp.has_results?).to be_truthy
        end

        it 'parse orders' do
          o1 = {
              :title => 'REWE',
              :payout => 40750,
              :thumbnail => {
               :lowres => 'http://cdn3.sponsorpay.com/assets/38646/Screen_Shot_2013-12-10_at_3.36.25_PM_square_60.png',
               :hires => 'http://cdn3.sponsorpay.com/assets/38646/Screen_Shot_2013-12-10_at_3.36.25_PM_square_175.png'
              }
          }
          o2 = {
              :title => 'RTEE',
              :payout => 454,
              :thumbnail => {
                  :lowres => 'http://cdn3.sponsorpay.com/assets/38646/Screen_Shot_2013-12-10_at_3.36.45455.png',
                  :hires => 'http://cdn3.sponsorpay.com/assets/38646/Screen_Shot_2013-12-10_at_3.36.d355.png'
              }
          }
          hash = {
              :count => 2,
              :offers => [o1, o2]
          }

          offers = ApiResponse.new(mock_http(body: JSON.generate(hash))).offers
          expect(offers.size).to be(2)

          compare(offers[0], o1)
          compare(offers[1], o2)

        end
      end

      def compare(offer, expected)
        expect(offer.id).to be(expected[:id])
        expect(offer.title).to eq(expected[:title])
        expect(offer.thumbnail_lowres).to eq(expected[:thumbnail][:lowres])
        expect(offer.payout).to eq(expected[:payout])
      end

      def mock_http(body: '{"foo" : "bar"}', hash: nil)
        hash = Digest::SHA1.hexdigest(body + 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f') if hash.nil?
        http_response = double('http response' + Time.now.getutc.to_s)
        allow(http_response).to receive(:body) { body }
        allow(http_response).to receive(:headers) do
          {:'x_sponsorpay_response_signature' => hash }
        end
        http_response
      end
    end





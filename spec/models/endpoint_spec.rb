require "rails_helper"

RSpec.describe Endpoint do

  describe '#validations' do

    context '#unsuccessful' do
      let!(:endpoint) { Endpoint.create(verb: 'GET', path: '/greeting', response_code: 200) }

      it 'returns error when duplicate path' do
        duplicate_endpoint = Endpoint.create(verb: 'GET', path: '/greeting', response_code: 200)
        expect(duplicate_endpoint.errors[:path]).to include('has already been taken')
      end

      it 'returns error without verb' do
        endpoint_with_no_verb = Endpoint.create(path: '/greetings', response_code: 200)
        expect(endpoint_with_no_verb.errors[:verb]).to include("can't be blank")
      end

      it 'returns error with invalid verb' do
        invalid_endpoint = Endpoint.update(verb: 'FOO')[0]
        expect(invalid_endpoint.errors[:verb]).to include("FOO is not a valid verb")
      end

      it 'returns error when invalid response_code' do
        invalid_endpoint = Endpoint.update(response_code: 'FOO')[0]
        expect(invalid_endpoint.errors[:response_code]).to include("is not a number")
      end
    end

  end

  describe '#methods' do
    let(:verb) { 'get' }
    let!(:endpoint) { Endpoint.new(verb: verb, path: '/greeting', response_code: 200) }

    it 'returns upcase verb' do
      endpoint.valid?
      expect(endpoint.verb).to eq(verb.upcase)
    end

  end
end
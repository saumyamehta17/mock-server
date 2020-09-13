require "rails_helper"

RSpec.describe EndpointsController do

  describe 'GET index' do
    it 'returns 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'returns 200' do
      endpoint_params = {verb: 'POST', path: '/greetings', response_code: 200,
                         response_headers: {},
                         response_body: "\"{ \"message\": \"Hello, everyone\" }\""}
      post :create, params: { endpoint: endpoint_params }
      body = JSON.parse(response.body)
      expect(body['verb']).to eq('POST')
    end
  end

  describe 'GET show' do
    it 'returns Not found when no endpoint is created' do
      get :show, params: {url: '/greetings'}
      byebug
      body = JSON.parse(response.body)
      expect(body['verb']).to eq('POST')
    end

    it 'returns endpoint' do
      get :show, params: {url: '/greetings'}
      body = JSON.parse(response.body)
      expect(body['verb']).to eq('POST')
    end
  end
end
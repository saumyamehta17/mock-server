require "rails_helper"

RSpec.describe EndpointsController do

  describe 'GET index' do
    it 'returns 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end


  describe 'POST create' do
    # it 'returns unprocessable_entity when response data is missing' do
    #   endpoint_params = {"data" => {
    #                     "type"=>"endpoints",
    #                     "id" => "12345",
    #                     "attributes"=>{
    #                       "verb"=>"GET",
    #                       "path"=>"/foo"
    #                     }
    #                   }}
    #   post :create, params: { endpoint: endpoint_params }

    #   expect(response).to have_http_status(:unprocessable_entity)
    # end

    it 'returns 200' do
      endpoint_params = {"data" => {
                            "type"=>"endpoints",
                            "id" => "12345",
                            "attributes"=>{
                              "verb"=>"GET",
                              "path"=>"/foo",
                              "response"=> {
                                "code"=>200,
                                "headers"=>{},
                                "body"=>"{\"message\":\"Hello world\"}"
                              }
                            }
                          },
                          "endpoint"=>{}
                        }

      post :create, params:  endpoint_params

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body['verb']).to eq('GET')
    end
  end

  describe 'GET show' do
    # it 'returns Not found when no endpoint is created' do
    #   get :show, params: {url: '/greetings'}
    #   byebug
    #   body = JSON.parse(response.body)
    #   expect(body['verb']).to eq('POST')
    # end

    # it 'returns endpoint' do
    #   get :show, params: {url: '/greetings'}
    #   body = JSON.parse(response.body)
    #   expect(body['verb']).to eq('POST')
    # end
  end
end

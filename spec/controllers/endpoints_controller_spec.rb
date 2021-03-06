require "rails_helper"

RSpec.describe EndpointsController do

  describe 'GET index' do
    it 'returns 200' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end
  end


  describe 'POST create' do

    it 'returns unprocessable_entity when response data is missing' do
      endpoint_params = {
        "data" => {
          "type"=>"endpoints",
          "attributes"=>{
            "verb"=>"GET",
            "path"=>"/greeting",
          }
        }
      }

      post :create, params: endpoint_params, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns unprocessable_entity when verb is invalid' do
      endpoint_params = {
        "data" => {
          "type"=>"endpoints",
          "attributes"=>{
            "verb"=>"FOO",
            "path"=>"/greeting",
            "response"=> {
              "code"=>200,
              "headers"=>{},
              "body"=>"{\"message\":\"Hello world\"}"
            }
          }
        }
      }
      post :create, params: endpoint_params, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns unprocessable_entity when path is invalid' do
      endpoint_params = {
        "data" => {
          "type"=>"endpoints",
          "attributes"=>{
            "verb"=>"GET",
            "path"=>"<>>",
            "response"=> {
              "code"=>200,
              "headers"=>{},
              "body"=>"{\"message\":\"Hello world\"}"
            }
          }
        }
      }

      post :create, params: endpoint_params, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'creates an endpoint' do
      endpoint_params = {
        "data" => {
          "type"=>"endpoints",
          "attributes"=>{
            "verb"=>"GET",
            "path"=>"/greeting",
            "response"=> {
              "code"=>200,
              "headers"=>{},
              "body"=>"{\"message\":\"Hello world\"}"
            }
          }
        }
      }

      post :create, params: endpoint_params, format: :json
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH update' do

    it 'updates an endpoint' do
      endpoint = Endpoint.create(verb: 'GET', path: '/greeting', response_code: 200)
      endpoint_params = {
        "id" => endpoint.id,
        "data" => {
          "type"=>"endpoints",
          "attributes"=>{
            "path"=>"/hello"
          }
        }
      }

      put :update, params: endpoint_params, format: :json
      expect(response.status).to eq(200)
      expect(endpoint.reload.path).to eq("/hello")
    end
  end

  describe 'DELETE destroy' do

    it 'deletes endpoint' do
      endpoint = Endpoint.create(verb: 'GET', path: '/greeting', response_code: 200)
      delete :destroy, params: { id: endpoint.id }, format: :json
      expect(response.status).to eq(204)
    end

    it 'returns no_content when no endpoint' do
      delete :destroy, params: { id: 'random_id' }, format: :json
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)["errors"][0]["detail"]).to eq("Requested Endpoint with ID `random_id` does not exist")
    end

  end
end

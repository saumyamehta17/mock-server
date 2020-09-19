require 'rails_helper'

RSpec.describe 'Client Requests', type: :request do

  it 'manages incoming requests' do
    headers = { "CONTENT_TYPE" => "application/json" }
    get '/greeting', headers: headers
    expect(response.status).to eq(404)
    expect(JSON.parse(response.body)["errors"][0]["detail"]).to eq("Requested page `greeting` does not exist")

    Endpoint.create(verb: 'GET', path: '/greeting', response_code: 200,
                    response_headers: {"Content-Type": "application/json"},
                    response_body: '{"message": "Hello, world" }')

    get '/greeting', headers: headers
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)["message"]).to eq("Hello, world")

    post '/greeting', headers: headers
    expect(response.status).to eq(404)
    expect(JSON.parse(response.body)["errors"][0]["detail"]).to eq("Requested page `greeting` does not exist")
  end
end
json.type "endpoints"
json.id endpoint.id.to_s

json.attributes do |innerJson|
  innerJson.(endpoint, :verb, :path)

  innerJson.response do |j|
    j.code endpoint.response_code
    j.headers (endpoint.response_headers || {})
    j.body endpoint.response_body
  end
end

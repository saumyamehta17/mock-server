class EndpointsController < ApplicationController

  before_action :set_endpoint, only: [:update, :destroy]
  before_action :translate_params, only: [:create, :update]
  before_action :validate_params, only: :create

  # GET /endpoints
  def index
    @endpoints = Endpoint.all
  end

  # GET /endpoint/:url
  def show
    endpoint = Endpoint.find_by! path: request.path, verb: request.method

    endpoint.response_headers.each {|k,v| response.set_header(k, v)}
    render inline: endpoint.response_body, status: endpoint.response_code
  end

  # POST /endpoints
  def create
    @endpoint = Endpoint.new(endpoint_params)

    if @endpoint.save
      render :show, status: :created
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /endpoints/1
  def update
    if @endpoint.update(endpoint_params)
      render :show
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /endpoints/1
  def destroy
    @endpoint.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      @endpoint = Endpoint.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def endpoint_params
      params.fetch(:data).permit(
        attributes: [:verb, :path, :response_code, :response_body, response_headers: {}]
      )
    end

    def translate_params
      return unless params[:data][:attributes][:response]
      params[:data][:attributes][:response_code] = params[:data][:attributes][:response][:code]
      params[:data][:attributes][:response_headers] = params[:data][:attributes][:response][:headers]
      params[:data][:attributes][:response_body] = params[:data][:attributes][:response][:body]
    end

    def validate_params
      params.require(:data).require(:attributes).require(:response)
    end

    def detail
      params[:id] ? "Requested Endpoint with ID `#{params[:id]}` does not exist" : "Requested page `#{params[:url]}` does not exist"
    end
end

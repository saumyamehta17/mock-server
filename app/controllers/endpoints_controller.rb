class EndpointsController < ApplicationController

  before_action :set_endpoint, only: [:update, :destroy]
  before_action :translate_params, only: [:create, :update]

  # GET /endpoints
  def index
    @endpoints = Endpoint.all
    # render json: @endpoints
  end

  def show
    endpoint = Endpoint.find_by path: params[:url]
    render json: {message: endpoint.response_body}
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
        attributes: [:verb, :path, :response_code, :response_body, response_headers: []]
      )
    end

    def translate_params
        params[:data][:attributes][:response_code] = params[:data][:attributes][:response][:code]
        params[:data][:attributes][:response_headers] = params[:data][:attributes][:response][:headers]
        params[:data][:attributes][:response_body] = params[:data][:attributes][:response][:body]
    end
end

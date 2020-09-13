class EndpointsController < ApplicationController
  before_action :set_endpoint, only: [:update, :destroy]

  # GET /endpoints
  def index
    # implement auth
    #
    @endpoints = Endpoint.all
    render json: @endpoints
  end

  def show
    # fix me
    # 404
    #
    endpoint = Endpoint.find_by path: params[:url]
    render json: {message: endpoint.response_body}
  end

  # POST /endpoints
  def create
    # todo
    #   validate data
    @endpoint = Endpoint.new(endpoint_params)

    if @endpoint.save
      render json: @endpoint, status: :created, location: @endpoint
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /endpoints/1
  def update
    # todo
    #   validate data
    if @endpoint.update(endpoint_params)
      render json: @endpoint
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /endpoints/1
  def destroy
    @endpoint.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      @endpoint = Endpoint.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def endpoint_params
      params.fetch(:endpoint).permit(:verb, :path, :response_code, :response_body, response_headers: {})
    end
end

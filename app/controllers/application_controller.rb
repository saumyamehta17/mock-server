class ApplicationController < ActionController::API
  include ::ActionView::Layouts
  rescue_from ActionController::ParameterMissing, with: :handle_invalid_params
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

   def handle_invalid_params
     render json: {}, status: :unprocessable_entity
   end

   def record_not_found
     render json: {}, status: :not_found
   end

end

class ApplicationController < ActionController::API
  include ::ActionView::Layouts
  rescue_from ActionController::ParameterMissing, with: :handle_invalid_params

  private

   def handle_invalid_params
     render json: {}, status: :unprocessable_entity
   end

end

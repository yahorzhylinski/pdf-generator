class ApplicationController < ActionController::API

  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

    def success_response(data, response_status)
      final_response("success", data, response_status)
    end

    def error_response(data, response_status)
      final_response("error", { errors: data }, response_status)
    end

    def final_response(status, data, response_status)
      render json: { status: status, data: data }, status: response_status
    end
end

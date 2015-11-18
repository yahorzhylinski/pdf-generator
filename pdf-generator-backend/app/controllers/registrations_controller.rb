class RegistrationsController < DeviseTokenAuth::RegistrationsController

  protected

    def sign_up_params
      params.require(:sign_up).permit(:username, :email, :password)
    end

    def account_update_params
      raise NotImplementedError.new
    end

end
class SessionsController < DeviseTokenAuth::SessionsController 

  # => overrided for log-in with email & username
  def create
    # Check

    @resource = nil
    if resource_params[:login]
      @resource = User.where("email = :login OR username = :login", login: resource_params[:login]).first  
    end

    # => this code from the parent controller
    if @resource && resource_params[:password] && @resource.valid_password?(resource_params[:password])

      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)

      @resource.tokens[@client_id] = {
        token: BCrypt::Password.create(@token),
        expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }
      @resource.save

      sign_in(:user, @resource, store: false, bypass: false)

      render_create_success
    else
      render_create_error_bad_credentials
    end
  end

  protected

    # => override for log-in with email & username
    def resource_params
      params.require(:sign_in).permit(:login, :password)
    end
    
end
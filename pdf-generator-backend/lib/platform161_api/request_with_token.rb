class Platform161Api::RequestWithToken < Platform161Api::Base

  TOKEN_KEY = 'PFM161-API-AccessToken'
                                      # => is from base class
  def initialize(action, request_type=DEFAULT_REQUEST_TYPE)

    super action, request_type

  end

  def send_request(params={})
    super(params) do | request |
      request.add_field(TOKEN_KEY, ::Platform161Api::Token.instance.token)
      request
    end
  end

end
class Platform161Api::Auth < Platform161Api::Base

  AUTH_ACTION = 'access_tokens'
  SUCCESS_RESPONSE = 201

  def initialize
    super AUTH_ACTION
  end

  def send_request
    params = {
      user: @configs['api_credentials']['user'],
      password: @configs['api_credentials']['password'],
      client_id: @configs['api_credentials']['client_id'],
      client_secret: @configs['api_credentials']['client_secret']
    }

    super(params)
  end

  def success?
    @response_status == SUCCESS_RESPONSE
  end

end
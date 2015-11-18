class Platform161Api::Token

  include Singleton

  SUCCESS_RESPONSE = 201

  EXPIRE_TIME = 12.hours

  CACHE_TOKEN_PATH = "token_platform_161_api"

  def token
    if !@token || !@created_at
      data_from_cache = ::Rails.cache.fetch(CACHE_TOKEN_PATH) || {}
      @token = data_from_cache[:token]
      @created_at = data_from_cache[:created_at]
    end

    if !is_valid?
      get_new_token!
    end

    @token
  end

  protected

    def get_new_token!

      auth = ::Platform161Api::Auth.new
      auth.send_request
      if auth.success?

        @token = auth.parsed_response['token']
        @created_at = DateTime.parse(auth.parsed_response['created_at'])

        ::Rails.cache.write(CACHE_TOKEN_PATH, { token: @token, created_at: @created_at }, expires_in: EXPIRE_TIME - 1.hour)
      end

      nil
    end

    def is_valid?
      (@token && @created_at + EXPIRE_TIME > DateTime.now.utc)
    end


end
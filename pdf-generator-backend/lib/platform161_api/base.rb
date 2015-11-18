class Platform161Api::Base

  attr_reader :parsed_response, :response_status

  SUCCESS_RESPONSE = 200

  DEFAULT_REQUEST_TYPE = :post

  def initialize(action, request_type=DEFAULT_REQUEST_TYPE)
    @configs = YAML.load_file("#{::Rails.root}/config/platform_161_api_credentials.yml")
    @url = @configs['api_credentials']['hostname'] + action
    @request_type = request_type
  end

  def send_request(parameters)
    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = (@request_type == :post ? Net::HTTP::Post : Net::HTTP::Get).new(uri.request_uri)
    request.add_field('Content-Type', 'application/json')

    request.body = parameters.to_json

    request = yield(request) if block_given?

    @response = http.request(request)

    @parsed_response = JSON.parse @response.body
    @response_status = @response.code.to_i
  end

  def success?
    @response_status == SUCCESS_RESPONSE
  end


end
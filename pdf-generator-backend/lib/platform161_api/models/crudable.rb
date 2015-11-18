module Platform161Api::Models::Crudable

  extend ActiveSupport::Concern

  FIND_REQUEST_TYPE = :get
  ALL_REQUEST_TYPE = :get

  def find id
    result = send_request self::BASE_URL + id.to_s, FIND_REQUEST_TYPE
    build_new_instance result
  end

  def all
    result = send_request self::BASE_URL, ALL_REQUEST_TYPE
    result.map { | item | build_new_instance item }
  end

  protected

    def custom_request(url, type, is_array)
      result = send_request url, type

      if is_array
        result.map { | item | build_new_instance item }
      else
        build_new_instance result
      end 
    end

    def build_new_instance fields
      result = self.new
      self::ATTRIBUTES.each do | name |
        result.define_singleton_method(name) { fields[name.to_s] }
      end

      result
    end

  private

    def check_base_action 
      raise Exception.new("BASE_URL is nil") if !self::BASE_URL
    end

    def check_attributes
      raise Exception.new("ATTRIBUTES is nil") if !self::ATTRIBUTES
    end

    def send_request(action, type)
      request = ::Platform161Api::RequestWithToken.new action, type
      request.send_request
      request.parsed_response
    end

end

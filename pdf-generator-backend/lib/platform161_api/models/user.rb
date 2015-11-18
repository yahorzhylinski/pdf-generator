class Platform161Api::Models::User

  extend Platform161Api::Models::Crudable

  ATTRIBUTES = [:last_name, :first_name]
  BASE_URL = "/users/"

  def to_json
    {
      last_name: last_name,
      first_name: first_name
    }
  end

end
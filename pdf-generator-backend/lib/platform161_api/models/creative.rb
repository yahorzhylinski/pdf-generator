class Platform161Api::Models::Creative

  extend Platform161Api::Models::Crudable
  include Platform161Api::Models::Statisticable

  ATTRIBUTES = [:name]
  BASE_URL = "/creatives/"

  def self.find_all_by_campaign_id campaign_id
                                                                                                    # => is array 
    custom_request Platform161Api::Models::Campaign::BASE_URL + campaign_id + "/" + BASE_URL, :get, true
  end

end
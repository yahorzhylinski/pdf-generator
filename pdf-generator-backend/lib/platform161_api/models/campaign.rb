class Platform161Api::Models::Campaign

  extend Platform161Api::Models::Crudable
  include Platform161Api::Models::Statisticable

  ATTRIBUTES = [:id, :name, :created_at, :start_on, :end_on, :campaign_manager_id, :sales_manager_id]
  BASE_URL = "/campaigns/"

end
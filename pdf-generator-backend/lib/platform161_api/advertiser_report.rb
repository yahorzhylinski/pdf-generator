class Platform161Api::AdvertiserReport < Platform161Api::RequestWithToken

  ACTION = "advertiser_reports"

  def initialize()
    super ACTION
  end

  def send_request
    params = {
                advertiser_report: {
                  groupings: [ :campaign, :creative ],
                  measures: [ :media_budget, :remaining_media_budget, :impressions, :clicks, :conversions, 
                              :ctr, :gross_revenues, :net_revenues, :campaign_cost, :total_campaign_cost ],
                  period: :last_30_days,
                  interval: :daily
                }
              }
    super params
  end

end
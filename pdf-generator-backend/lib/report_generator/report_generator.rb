class ReportGenerator::ReportGenerator

  attr_reader :pdf, :json, :html

  def initialize
  end

  def generate! campaign_id, report
    # => get campaign info
    campaign = ::Platform161Api::Models::Campaign.find campaign_id

    # => campaign manager
    campaign_manager = campaign.campaign_manager_id ? ::Platform161Api::Models::User.find(campaign.campaign_manager_id) : nil

    # => account manager
    account_manager = campaign.sales_manager_id ? ::Platform161Api::Models::User.find(campaign.sales_manager_id) : nil

    # => generate days
    days = []
    daysTmp = report.group_by { |d| d["date"] }
    daysTmp.keys.sort.each do | key |
      day = Platform161Api::Models::Day.new
      day.get_statistic! daysTmp[key]
      day.name = key 
      days << day
    end

    # => get all creatives
    campaign.get_statistic! report

    creatives = []

    report.group_by { |r| r["creative_id"]}.each do | creative_info |
      creative = ::Platform161Api::Models::Creative.new
      creative.get_statistic! creative_info[1]
      creatives << creative
    end

    generate_report campaign, campaign_manager, account_manager, days, creatives
  end

  private

      def generate_report(campaign, campaign_manager, account_manager, days, creatives)
        @html = ::ReportGenerator::HtmlGenerator.new(campaign, account_manager, campaign_manager, days, creatives).render
        @pdf = WickedPdf.new.pdf_from_string(@html, javascript_delay: 5000)
        @json = {
                  campaign: campaign.to_json, 
                  account_manager: account_manager.to_json, 
                  campaign_manager: campaign_manager.to_json, 
                  days: days.map{ | d | d.to_json },
                  creatives: creatives.map{ | c | c.to_json }
                }
      end


end
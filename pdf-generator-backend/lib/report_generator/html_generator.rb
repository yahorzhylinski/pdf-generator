class ReportGenerator::HtmlGenerator

  include ERB::Util

  attr_accessor :campaign

  TEMPLATE_PATH = "#{Rails.root}/report-template/pdf_layout.html"

  def initialize(campaign, account_manager, campaign_manager, days, creatives)
    @campaign = campaign
    @account_manager = account_manager
    @campaign_manager = campaign_manager
    @days = days
    @creatives = creatives
  end

  def render()
    ERB.new(File.read(TEMPLATE_PATH)).result(binding)
  end

end
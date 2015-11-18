module Platform161Api::Models::Statisticable

  attr_accessor :media_budget, :media_spent, :impressions, :clicks, :ctr, :conversions, :ecpm, :ecpc, :ecpa, :name

  def get_statistic! data
    if !data
      @media_budget =  @media_spent = @impressions = @clicks = @ctr = @conversions = @ecpm = @ecpc = @ecpa = 0.0
      return
    end

    @media_budget  = (data.map { | el | el["media_budget"].to_f }.compact).inject(:+) || 0.0
    @media_spent   = (data.map { | el | el["total_campaign_cost"].to_f }.compact).inject(:+) || 0.0
    @impressions   = (data.map { | el | el["impressions"].to_f }.compact).inject(:+) || 0.0
    @clicks        = (data.map { | el | el["clicks"].to_f }.compact).inject(:+) || 0.0
    @ctr           = (data.map { | el | el["ctr"].to_f }.compact).inject(:+) || 0.0
    @conversions   = (data.map { | el | el["conversions"].to_f}.compact).inject(:+) || 0.0
    gross_revenues = (data.map { | el | el["gross_revenues"].to_f }.compact).inject(:+) || 0.0
    @ecpm = @impressions == 0.0 ? 0.0 : gross_revenues / (@impressions * 1000)
    @ecpc = @clicks == 0.0 ? 0.0 : gross_revenues / @clicks
    @ecpa = @conversions == 0.0 ? 0.0 : gross_revenues / @conversions
    if data[0]
      @name = data[0]["name"] || data[0]["creative_name"]
    end
  end 

  def to_json
    {
      media_budget: @media_budget,
      media_spent: @media_spent,
      impressions: @impressions,
      clicks: @clicks,
      ctr: @ctr,
      conversions: @conversions,
      ecpm: @ecpm,
      ecpc: @ecpc,
      ecpa: @ecpa,
      name: @name
    }
  end

end

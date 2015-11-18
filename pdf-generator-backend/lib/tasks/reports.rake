namespace :reports do

  desc "Generate reports"
  task create: :environment do

    # => at first get current report
    advertiser_reports = ::Platform161Api::AdvertiserReport.new
    advertiser_reports.send_request

    p "Reports were downloaded"

    # => group reports by campaign_id
    sorted_reports = {}
    advertiser_reports.parsed_response["results"].map do | campaign_day |


      if !sorted_reports[campaign_day["campaign_id"].to_s]
        sorted_reports[campaign_day["campaign_id"].to_s] = []
      end

      sorted_reports[campaign_day["campaign_id"].to_s] << campaign_day
      p campaign_day["campaign_id"].to_s
    end

    # => get all current pending user reports
    UserReport.pending.group_by(&:campaign_id).each do | campaign_id, user_reports |

      if sorted_reports[campaign_id.to_s]

        # => now trying to generate report
        report_generator = ::ReportGenerator::ReportGenerator.new 
                                                                    # => group by dates
        report_generator.generate! campaign_id, sorted_reports[campaign_id.to_s]

        # => create report 
        report = ::Report.new
        report.save_report! report_generator

        # => bind created report to each user request
        user_reports.each do | user_report |
          user_report.complete_user_request report
        end

      else

        # => if we didn't get info about current campaign it means that campaign is invalid
        user_reports.each do | user_report |
          user_report.complete_user_request nil
        end
      end

    end
  end

end
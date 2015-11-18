class ReportsController < ApplicationController

  before_action :authenticate_user!

  REPORT_WASNT_FOUND_ERROR = "Report with id = '%s' wasn't found"

  def index
    success_response current_user.user_reports, :ok
  end

  def show
    user_report = UserReport.where(id: params[:id]).first
    if user_report
      success_response user_report.as_json, :ok
    else
      error_response (REPORT_WASNT_FOUND_ERROR % [params[:id]]), :not_found
    end
  end

  def create
    user_report = UserReport.new report_params
    user_report.user = current_user
    if user_report.save
      success_response user_report.as_json, :created
    else
      error_response user_report.errors.full_messages, :forbidden
    end
  end

  def update
    user_report = UserReport.where(id: params[:id]).first

    if !user_report
      error_response (REPORT_WASNT_FOUND_ERROR % [params[:id]]), :not_found      
    else
      user_report.attributes = report_update_params
      if user_report.save
        success_response user_report.as_json, :accepted
      else
        error_response user_report.errors.full_messages, :forbidden
      end
    end      
  end

  def get_report_file
    user_report = UserReport.where(id: params[:id]).first
    if user_report
      file_path = REPORT_PATH % [user_report.report.file_name]
      if params[:format] == 'json'
        report_json = File.read(file_path + ".json")
        render text: report_json
      else
        send_file file_path + ".pdf", type: 'application/pdf', disposition: 'inline'
      end
    else
      error_response (REPORT_WASNT_FOUND_ERROR % [params[:id]]), :not_found
    end

  end

  protected

    def report_params
      params.fetch(:report, {}).permit(:campaign_id, :comment)
    end

    def report_update_params
      params.fetch(:report, {}).permit(:comment)
    end

end
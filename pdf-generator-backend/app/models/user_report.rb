class UserReport < ActiveRecord::Base

  MAX_COMMENT_LENGTH = 160
  MAX_CAMPAING_ID_LENGTH = 20

  enum status: [:pending, :generated, :error]
  # => is using in rake cmd
  scope :pending, -> { where status: 'pending' }

  belongs_to :user
  belongs_to :report

  validates :user, presence: true

  validates :comment, length: { maximum: MAX_COMMENT_LENGTH }
  validates :campaign_id, presence: true, length: { maximum: MAX_CAMPAING_ID_LENGTH }
  validates :status, inclusion: { in: UserReport.statuses.keys }

  def complete_user_request report
    if report
      self.report = report
      self.status = :generated
    else
      self.status = :error
    end

    self.save!
  end

  def as_json(options={})
    super only: [:id, :status, :comment, :campaign_id, :created_at]
  end
end

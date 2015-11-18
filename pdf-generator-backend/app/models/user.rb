class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :validatable

  include DeviseTokenAuth::Concerns::User

  MAX_USERNAME_LENGTH = 50

  validates :username, presence: true, length: { maximum: MAX_USERNAME_LENGTH }, uniqueness: true

  # => validate username to be unique for already saved emails
  validate :validate_username

  has_many :user_reports, dependent: :delete_all 
  has_many :reports, through: :user_reports, dependent: :delete_all

  private

    def validate_username
      if User.where(email: username).exists?
        errors.add(:username, :invalid)
      end
    end

end

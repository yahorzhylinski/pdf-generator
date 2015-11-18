class Report < ActiveRecord::Base

  PDF_FILE_NAME_LENGTH = 100

  has_many :user_reports, dependent: :delete_all
  has_many :users, through: :user_reports, dependent: :delete_all

  validates :file_name, uniqueness: true
  
  def save_report!(report_generator)

    generate_pdf_file_name!

    save_path = REPORT_PATH % [self.file_name]

    # => save html
    File.open(save_path + ".html", 'wb') do |file|
      file << report_generator.html
    end

    # => save pdf
    File.open(save_path + ".pdf", 'wb') do |file|
      file << report_generator.pdf
    end

    # => save json
    File.open(save_path + ".json", 'wb') do |file|
      file << report_generator.json
    end

    self.save!
  end

  private

    def generate_pdf_file_name!
      while true
        self.file_name = SecureRandom.hex(PDF_FILE_NAME_LENGTH)

        # => file_name should be unique
        if !Report.where(file_name: self.file_name).first
          return
        end
      end
    end

end

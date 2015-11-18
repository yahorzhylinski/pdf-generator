class CreateUserReports < ActiveRecord::Migration
  def change
    create_table :user_reports do |t|
      t.integer :user_id
      t.integer :report_id
      t.integer :campaign_id, null: false
      t.integer :status, default: 0, null: false
      t.string :comment
      t.timestamps null: false
    end

    add_foreign_key :user_reports, :users
    add_foreign_key :user_reports, :reports

  end
end

class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :file_name, unique: true
      t.timestamps null: false
    end

  end
end

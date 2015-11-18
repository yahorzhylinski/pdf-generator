class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :email

      ## Tokens
      t.text :tokens

      t.timestamps
    end

    add_index :users, :email
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
  end
end

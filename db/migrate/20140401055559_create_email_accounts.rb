class CreateEmailAccounts < ActiveRecord::Migration
  def change
    create_table :email_accounts do |t|
      t.references :merchant, index: true
      t.string :email_address
      t.string :unencrypted_password
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :email_accounts, [:email_address], unique: true
  end
end

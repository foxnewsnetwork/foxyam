class CreateEmailInboxes < ActiveRecord::Migration
  def change
    create_table :email_inboxes do |t|
      t.references :negotiation, index: true
      t.string :email_address
      t.timestamps
    end
    add_index :email_inboxes, [:email_address], unique: true
  end
end

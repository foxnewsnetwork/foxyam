class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :conversation, index: true
      t.references :email_inbox, index: true
      t.string :external_id
      t.text :raw_envelope
      t.text :raw_body
      t.timestamps
    end
    add_index :emails, [:external_id]
  end
end

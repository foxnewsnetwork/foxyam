class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :conversation, index: true
      t.references :email_inbox, index: true
      t.string :external_id
      t.text :plain_content
      t.text :html_content
      t.timestamps
    end
    add_index :emails, [:external_id]
  end
end

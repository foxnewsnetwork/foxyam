class CreateQueuesEmailScrapRequests < ActiveRecord::Migration
  def change
    create_table :queues_email_scrap_requests do |t|
      t.references :email_account, index: true
      t.integer :priority, null: false, default: 0
      t.timestamps
    end
  end
end

class CreateQueuesEmailScrapFulfilments < ActiveRecord::Migration
  def change
    create_table :queues_email_scrap_fulfilments do |t|
      t.references :request, index: true
      t.datetime :succeed_at
      t.datetime :failed_at
      t.datetime :tried_at
      t.timestamps
    end
  end
end

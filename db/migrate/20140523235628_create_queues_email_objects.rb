class CreateQueuesEmailObjects < ActiveRecord::Migration
  def change
    create_table :queues_email_objects do |t|
      t.references :request, index: true
      t.string :external_name, null: false
      t.string :external_id, null: false
      t.timestamps
    end
  end
end

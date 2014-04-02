class CreateConversationsRawLogs < ActiveRecord::Migration
  def change
    create_table :conversations_raw_logs do |t|
      t.references :conversation, index: true
      t.text :content
      t.timestamps
    end
  end
end

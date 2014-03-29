class CreateConversationsLoads < ActiveRecord::Migration
  def change
    create_table :conversations_loads do |t|
      t.references :conversation, index: true
      t.integer :loads
      t.string :container_size
      t.string :notes
    end
  end
end

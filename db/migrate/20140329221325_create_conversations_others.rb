class CreateConversationsOthers < ActiveRecord::Migration
  def change
    create_table :conversations_others do |t|
      t.references :conversation, index: true
      t.text :notes
      t.timestamps
    end
  end
end

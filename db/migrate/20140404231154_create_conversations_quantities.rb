class CreateConversationsQuantities < ActiveRecord::Migration
  def change
    create_table :conversations_quantities do |t|
      t.integer :quantity, null: false
      t.string :units, null: false
      t.string :notes
      t.string :time_interval, null: false, default: 'one-time'
      t.references :conversation, index: true
      t.timestamps
    end
  end
end

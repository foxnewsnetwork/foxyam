class CreateConversationsPackingWeights < ActiveRecord::Migration
  def change
    create_table :conversations_packing_weights do |t|
      t.references :conversation, index: true
      t.integer :packing_weight_pounds
      t.string :container_size
      t.string :notes
      t.timestamps
    end
  end
end

class CreateConversationsWeights < ActiveRecord::Migration
  def change
    create_table :conversations_weights do |t|
      t.references :conversation, index: true
      t.integer :total_weight_pounds
      t.string :notes
    end
  end
end

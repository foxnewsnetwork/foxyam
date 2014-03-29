class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :offer, index: true
      t.references :company, index: false
      t.string :via, null: false, default: 'gmail'
      t.timestamps
    end
  end
end

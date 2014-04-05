class CreateConversationsPrices < ActiveRecord::Migration
  def change
    create_table :conversations_prices do |t|
      t.references :conversation, index: true
      t.references :place, index: true
      t.decimal :usd_per_pound, scale: 5, precision: 12, null: false
      t.string :incoterm, null: false, default: 'EXW'
      t.string :notes
      t.timestamps
    end
  end
end

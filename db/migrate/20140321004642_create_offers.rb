class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :offer_type, null: false, default: 'sell'
      t.references :company, index: true
      t.references :negotiation, index: true
      t.timestamps
    end
  end
end

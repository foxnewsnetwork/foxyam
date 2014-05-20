class CreateFoxYamOffersContracts < ActiveRecord::Migration
  def change
    create_table :fox_yam_offers_contracts do |t|
      t.references :offer, index: true
      t.references :contract, index: false
      t.string :status, null: false, default: 'normal'
      t.timestamps
    end
    add_index :fox_yam_offers_contracts, [:contract_id], unique: true
  end
end

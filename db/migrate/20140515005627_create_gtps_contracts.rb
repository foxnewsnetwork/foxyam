class CreateGtpsContracts < ActiveRecord::Migration
  def change
    create_table :gtps_contracts do |t|
      t.datetime :draft_completed_at
      t.datetime :contract_live_at
      t.datetime :everyone_agreed_at
      t.datetime :contract_disputed_at
      t.datetime :contract_completed_at
      t.datetime :contract_canceled_at
      t.timestamps
    end
  end
end

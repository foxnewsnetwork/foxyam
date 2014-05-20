class CreateGtpsTransportationRequirements < ActiveRecord::Migration
  def change
    create_table :gtps_transportation_requirements do |t|
      t.references :contract, index: true
      t.string :name, null: false
      t.string :condition
      t.datetime :violated_at
      t.string :notes
      t.timestamps
    end
  end
end

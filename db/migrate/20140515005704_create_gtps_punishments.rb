class CreateGtpsPunishments < ActiveRecord::Migration
  def change
    create_table :gtps_punishments do |t|
      t.references :contract, index: true
      t.string :name
      t.integer :upper_limit
      t.integer :lower_limit
      t.string :notes
      t.timestamps
    end
  end
end

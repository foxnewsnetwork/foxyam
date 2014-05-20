class CreateGtpsParties < ActiveRecord::Migration
  def change
    create_table :gtps_parties do |t|
      t.references :contract, index: true
      t.string :email
      t.string :company_name
      t.string :phone_number
      t.string :address1
      t.string :address2
      t.string :city
      t.string :province
      t.string :country
      t.string :party_type, null: false
      t.timestamps
    end
  end
end

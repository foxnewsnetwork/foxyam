class CreateUsersMerchants < ActiveRecord::Migration
  def change
    create_table :users_merchants do |t|
      t.references :user, index: true
      t.references :merchant, index: true
      t.string :clearance, null: false, default: 'employee'
      t.timestamps
    end
  end
end

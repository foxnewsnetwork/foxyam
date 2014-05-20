class AddMerchantEmailToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :merchant_email, :string
  end
end

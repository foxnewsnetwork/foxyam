class AddMerchantToCompanies < ActiveRecord::Migration
  def change
    add_reference :companies, :merchant, index: true
  end
end

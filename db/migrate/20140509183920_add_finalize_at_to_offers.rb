class AddFinalizeAtToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :merchant_finalized_at, :datetime
    add_column :offers, :company_finalized_at, :datetime
  end
end

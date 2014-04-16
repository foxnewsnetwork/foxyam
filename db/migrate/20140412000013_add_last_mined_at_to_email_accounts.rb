class AddLastMinedAtToEmailAccounts < ActiveRecord::Migration
  def change
    add_column :email_accounts, :last_mined_at, :datetime
  end
end

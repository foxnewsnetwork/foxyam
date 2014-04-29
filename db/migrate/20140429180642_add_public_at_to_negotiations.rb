class AddPublicAtToNegotiations < ActiveRecord::Migration
  def change
    add_column :negotiations, :public_at, :datetime
  end
end

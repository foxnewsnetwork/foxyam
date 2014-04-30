class AddNegotiationTypeToNegotiations < ActiveRecord::Migration
  def change
    add_column :negotiations, :negotiation_type, :string
  end
end

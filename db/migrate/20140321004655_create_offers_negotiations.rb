class CreateOffersNegotiations < ActiveRecord::Migration
  def change
    create_table :offers_negotiations do |t|

      t.timestamps
    end
  end
end

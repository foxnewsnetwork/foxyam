class CreateNegotiations < ActiveRecord::Migration
  def change
    create_table :negotiations do |t|

      t.timestamps
    end
  end
end

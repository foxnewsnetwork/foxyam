class CreateNegotiations < ActiveRecord::Migration
  def change
    create_table :negotiations do |t|
      t.datetime :deleted_at
      t.datetime :dead_at
      t.datetime :finalized_at
      t.datetime :completed_at
      t.timestamps
    end
  end
end

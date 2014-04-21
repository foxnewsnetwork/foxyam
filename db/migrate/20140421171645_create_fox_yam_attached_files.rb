class CreateFoxYamAttachedFiles < ActiveRecord::Migration
  def change
    create_table :fox_yam_attached_files do |t|
      t.string :description
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

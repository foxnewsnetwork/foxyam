class CreateAttachedFilesPictures < ActiveRecord::Migration
  def change
    create_table :attached_files_pictures do |t|
      t.references :attached_file, index: true
      t.references :picture, index: true
      t.timestamps
    end
  end
end

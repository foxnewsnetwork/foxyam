# == Schema Information
#
# Table name: attached_files_pictures
#
#  id               :integer          not null, primary key
#  attached_file_id :integer
#  picture_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class FoxYam::AttachedFiles::AttachedFilesConversationsPictures < ActiveRecord::Base
  self.table_name = 'attached_files_pictures'
  belongs_to :attached_file,
    foreign_key: 'attached_file_id',
    class_name: 'FoxYam::AttachedFile'

  belongs_to :picture,
    foreign_key: 'picture_id',
    class_name: 'FoxYam::Conversations::Picture'
end

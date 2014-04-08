# == Schema Information
#
# Table name: conversations_pictures
#
#  id                   :integer          not null, primary key
#  conversation_id      :integer
#  notes                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Conversations::Picture < Conversations::RawLog
  self.table_name = 'conversations_pictures'
  belongs_to :conversation

  has_attached_file :picture,
    url: '/storage/files/:id/:basename.:extension',
    path: ':rails_root/public/storage/files/:id/:basename.:extension'


end

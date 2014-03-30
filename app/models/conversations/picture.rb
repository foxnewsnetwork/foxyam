# == Schema Information
#
# Table name: conversations_pictures
#
#  id                   :integer          not null, primary key
#  conversation_id      :integer
#  notes                :string(255)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Conversations::Picture < ActiveRecord::Base
  self.table_name = 'conversations_pictures'
  belongs_to :conversation
end

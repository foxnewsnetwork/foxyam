# == Schema Information
#
# Table name: queues_email_objects
#
#  id            :integer          not null, primary key
#  request_id    :integer
#  external_name :string(255)      not null
#  external_id   :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Queues::EmailObject < ActiveRecord::Base
  self.table_name = 'queues_email_objects'
  belongs_to :request,
    class_name: 'Queues::EmailDeliveryRequest'
end

class AddNotesToQueuesEmailDeliveryRequests < ActiveRecord::Migration
  def change
    add_column :queues_email_delivery_requests, :notes, :text
  end
end

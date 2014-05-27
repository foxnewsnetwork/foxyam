class CreateQueuesEmailDeliveryRequests < ActiveRecord::Migration
  def change
    create_table :queues_email_delivery_requests do |t|
      t.string :mail_to
      t.string :mail_from
      t.string :mail_cc_to
      t.string :mail_bcc_to
      t.string :mail_subject
      t.string :mailer_class, null: false
      t.string :mailer_method, null: false
      t.timestamps
    end
  end
end

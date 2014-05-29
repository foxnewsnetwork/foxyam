# == Schema Information
#
# Table name: gtps_documents
#
#  id                    :integer          not null, primary key
#  contract_id           :integer
#  document_type         :string(255)      not null
#  approved_at           :datetime
#  rejected_at           :datetime
#  created_at            :datetime
#  updated_at            :datetime
#  the_file_file_name    :string(255)
#  the_file_content_type :string(255)
#  the_file_file_size    :integer
#  the_file_updated_at   :datetime
#

class Gtps::Document < ActiveRecord::Base
  KnownTypes = [
    :preloading_pictures,
    :weight_ticket,
    :loading_pictures,
    :bill_of_lading,
    :packing_list,
    :invoice
  ].freeze
  self.table_name = 'gtps_documents'
  belongs_to :contract,
    class_name: 'Gtps::Contract'

  if Rails.env.test?
    has_attached_file :the_file,
      url: '/storage/test_docs/:id/:basename.:extension',
      path: ':rails_root/public/storage/test_docs/:id/:basename.:extension'
  elsif Rails.env.development?
    has_attached_file :the_file,
      url: '/storage/dev_docs/:id/:basename.:extension',
      path: ':rails_root/public/storage/dev_docs/:id/:basename.:extension'
  else
    has_attached_file :the_file,
      url: '/storage/docs/:id/:basename.:extension',
      path: ':rails_root/public/storage/docs/:id/:basename.:extension'
  end

  do_not_validate_attachment_file_type :the_file

  def fulfilled?
    the_file.present?
  end

  def wanting?
    !fulfilled?
  end

  def approved?
    fulfilled? && approved_at.to_i > rejected_at.to_i
  end

  def rejected?
    fulfilled? && rejected_at.to_i > approved_at.to_i
  end
end

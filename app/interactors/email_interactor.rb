class EmailInteractor

  attr_accessor :email, :inbox
  def initialize(email: email, inbox: inbox)
    @email = email
    @inbox = inbox
  end

  def store_email
    _email_record && _email_attachments
  end

  def message_id
    email.message.message_id
  end

  private
  def _email_record
    @email_record ||= inbox.emails.find_by_external_id(message_id) || 
      inbox.emails.create(external_id: message_id).update_from_gmail(email)
  end
  
  def _email_attachments
    email.message.attachments.map do |attachment|
      _email_record.attached_files.create! _to_attachment_params attachment
    end
  end

  def _to_attachment_params(attachment)
    {
      the_file: _image_file(attachment)
    }
  end

  def _image_file(attachment)
    _tempfile_for(attachment).tap do |f|
      f.write attachment.read
    end
  end

  def _tempfile_for(attachment)
    Paperclip::Tempfile.new(attachment.filename, encoding: 'ascii-8bit')
  end
end
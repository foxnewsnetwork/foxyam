require 'spec_helper'

describe EmailInteractor do
  let(:email) { Factories::Gmail.mock }
  let(:inbox) { Factories::EmailInbox.mock }
  let(:interactor) { EmailInteractor.new email: email, inbox: inbox }
  let(:attachment) { email.message.attachments.first }
  let(:store_email) { interactor.store_email }
  context 'attached_file' do
    let(:tempfile) { Paperclip::Tempfile.new(['gotes', '.jpg'], encoding: 'ascii-8bit') }
    let(:imgfile) { tempfile.write(attachment.read); tempfile }
    let(:file) { FoxYam::AttachedFile.create! the_file: imgfile }
    it 'should create the damn file' do
      imgfile.should be_present
      imgfile.should be_a Paperclip::Tempfile
    end
    it 'should successfully create the file' do
      expect { file }.to change(FoxYam::AttachedFile, :count).by 1
    end
    it 'should have the file' do
      file.the_file_file_name.should be_present
      file.the_file.should be_present
    end
  end
  describe '#store_email' do
    it 'should have a valid attachment' do
      attachment.read.should be_present
    end
    it 'should create an email' do
      expect { store_email }.to change(FoxYam::Email, :count).by 1
    end
    it 'should should be properly connected to the inbox' do
      expect { store_email }.to change(inbox.emails, :count).by 1
    end
    it 'should create an attached file' do
      expect { store_email }.to change(FoxYam::AttachedFile, :count).by 1
    end
    it 'should create the relationship object' do
      expect { store_email }.to change(FoxYam::AttachedFiles::AttachedFilesEmails, :count).by 1
    end
  end
  context 'relationships' do
    let(:email_record) { inbox.emails.first }
    let(:from_address) { email_record.envelope.from_address }
    before do
      store_email
    end  
    it 'should be a persisted record' do
      email_record.should be_persisted
    end
    it 'should have attachments' do
      email_record.attachments.should be_present
      email_record.attachments.first.should be_a FoxYam::AttachedFile
    end
    it 'should be correctly related' do
      email_record.attachments.first.emails.first.should eq email_record
    end
    it 'should properly create the envelope object' do
      email_record.envelope.should be_a FoxYam::Envelope
      email_record.envelope.email.should eq email_record
    end
    it 'should be a proper envelope origin' do
      from_address.should be_a FoxYam::Envelopes::Origin
      from_address.should be_persisted
      from_address.email_address.should eq "foxnewsnetwork@gmail.com"
    end
    it 'should be properly related' do
      from_address.envelope.should eq email_record.envelope
    end
  end
end
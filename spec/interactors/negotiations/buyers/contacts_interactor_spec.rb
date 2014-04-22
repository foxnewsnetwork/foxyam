require 'spec_helper'

describe Negotiations::Buyers::ContactsInteractor do

  let(:interactor) { Negotiations::Buyers::ContactsInteractor.new.tap { |i| i.attributes = @params } }
  describe '#contacts!' do
    let(:contacts) { interactor.contacts! }
    class FauxContactProxy
      def find_or_create_by(*whatever)
        FoxYam::Contact.new
      end
    end
    before do
      @params = {
        to: 'Miku Hatsune (miku@hatsu.ne)',
        cc: 'Luka Megurine (luka@meguri.ne), IA (ia@vocalo.id)'
      }
      interactor.stub(:_contacts_proxy).and_return(FauxContactProxy.new)
    end
    it 'should give me an array of contacts' do
      contacts.count.should eq 3
      contacts.each do |contact|
        contact.should be_a FoxYam::Contact
      end
    end

  end
  describe '#_grab_email_part' do
    let(:email) { lambda { |e| interactor.send :_grab_email_part, e } }
    before do
      @params = {}
      @email = 'Jack Thompson (jtom@gmail.com)'
      @e2 = 'jtom@gmail.com'
    end
    it 'should pull out the email' do
      email.call(@email).should eq 'jtom@gmail.com'
    end
    it 'should pull pretty much just return' do
      email.call(@e2).should eq 'jtom@gmail.com'
    end
    it 'should return with nothing if the string is malformed' do
      email.call('kjdfkjd js  jdf').should be_blank
      email.call('').should be_blank
      email.call('wow@doge.com opstahp@doge.com').should eq 'opstahp@doge.com'
    end
  end
  describe '#_grab_name_part' do
    let(:party) { interactor.send :_grab_name_part, @email }
    context 'good' do
      before { @email = 'Terrance Davis (tdavis@yahoo.co.jp)' }
      it 'should pull out the name' do
        party.should eq 'Terrance Davis'
      end
    end
    context 'just email' do
      before { @email = '(tdavis@yahoo.co.jp)' }
      it 'should pull out the name' do
        party.should be_blank
      end
    end
    context 'still just email' do
      before { @email = 'tdavis@yahoo.co.jp' }
      it 'should pull out the name' do
        party.should eq ''
      end
    end
    context 'just name' do
      before { @email = 'The Artist Formerly Known As Price' }
      it 'should pull out the name' do
        party.should eq 'The Artist Formerly Known As Price'
      end
    end
    context 'nothing' do
      before { @email = '' }
      it 'should pull out the name' do
        party.should be_blank
      end
    end
  end
  describe '#_array_of_contact_hash' do
    let(:contacts) { interactor.send :_array_of_contact_hash, @emails }
    context 'good' do
      before do 
        @emails = 'Freddy Mac (fmac@us.gov), Fannie Mae (fmae@us.gov), Bear Sterns (bear@ch9.gov)'
        @expected = [
          { name: 'Freddy Mac', email: 'fmac@us.gov' },
          { name: 'Fannie Mae', email: 'fmae@us.gov' },
          { name: 'Bear Sterns', email: 'bear@ch9.gov' }
        ]
      end
      it 'should pull out the names and places' do
        contacts.should eq @expected
      end
    end
    context 'mixed emails' do
      before do 
        @emails = '(fmac@us.gov), fmae@us.gov, Bear Sterns (bear@ch9.gov)'
        @expected = [
          { name: '', email: 'fmac@us.gov' },
          { name: '', email: 'fmae@us.gov' },
          { name: 'Bear Sterns', email: 'bear@ch9.gov' }
        ]
      end
      it 'should pull out the names and places' do
        contacts.should eq @expected
      end
    end
    context 'partial malformed emails' do
      before do 
        @emails = '(fmac@us.gov), fmae@us.gov, Bear Sterns'
        @expected = [
          { name: '', email: 'fmac@us.gov' },
          { name: '', email: 'fmae@us.gov' },
          { name: 'Bear Sterns', email: 'bear@ch9.gov' }
        ]
      end
      it 'should pull out the names and places' do
        expect { contacts }.to raise_error Negotiations::Buyers::ContactsInteractor::MalformatEmail
      end
    end
  end
end
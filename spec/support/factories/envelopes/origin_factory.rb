module Factories::Envelopes; end
class Factories::Envelopes::Origin < Factories::Base
  attr_accessor :envelope, :gmail
  def initialize(gmail=nil)
    @envelope = Factories::Envelope.mock
    @gmail = gmail
  end

  def belongs_to(thing)
    tap do |f|
      f.envelope = thing if thing.is_a? FoxYam::Envelope
    end
  end

  def attributes
    {
      envelope: envelope,
      origin_type: :from,
      email_address: Faker::Internet.email,
      email_presentation: Faker::Company.name
    }
  end
end
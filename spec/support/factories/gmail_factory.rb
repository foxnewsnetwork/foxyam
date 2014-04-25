class Factories::Gmail
  class Attachment
    def filename
      Faker::Company.bs.to_url
    end
    def read
      binary = nil
      File.open(Rails.root.join('public', 'gotes.jpg'), 'rb') do |f|
        binary = f.read
      end
      binary
    end
  end
  class << self
    def envelope_path
      gmail_path 'envelope.yml'
    end
    def body_path
      gmail_path 'body.yml'
    end
    def gmail_path(str)
      Rails.root.join 'spec', 'support', 'fixtures', 'gmails', str
    end
    def envelope
      YAML.load File.read envelope_path
    end
    def body
      YAML.load File.read body_path
    end
    def attributes
      {
        external_id: rand(99999999).to_alphabet,
        envelope: envelope,
        body: body
      }
    end
    def mock
      new
    end
  end
  def initialize
    @struct = OpenStruct.new
    struct.message = OpenStruct.new
    struct.message.message_id = Faker::Lorem.sentence.to_url
    struct.text_part = Faker::Lorem.sentence
    struct.html_part = Faker::Lorem.sentence
    struct.message.attachments = [Factories::Gmail::Attachment.new]
    struct.envelope = self.class.attributes[:envelope]
  end
  attr_accessor :struct
  delegate :envelope,
    :message,
    :text_part,
    :html_part,
    to: :struct
end
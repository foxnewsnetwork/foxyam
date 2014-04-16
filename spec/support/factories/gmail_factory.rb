class Factories::Gmail
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
    struct.message.body = self.class.attributes[:body]
    struct.envelope = self.class.attributes[:envelope]
  end
  attr_accessor :struct
  delegate :envelope,
    :message,
    to: :struct
end
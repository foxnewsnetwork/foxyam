class Factories::Conversations::Material
  class << self
    def belongs_to(c)
      new.tap { |a| a.conversation = c }
    end
  end
  attr_accessor :conversation

  def mock
    interactor.tap(&:tag!).tag
  end

  def interactor
    _interactor.tap do |i|
      i.attributes = moded_attributes
    end
  end

  def moded_attributes
    attributes.merge tag_type: _class_name
  end


  def attributes
    {
      place_name: Faker::Lorem.sentence,
      material: Faker::Lorem.sentence,
      notes: Faker::Lorem.sentence
    }
  end

  private
  def _class_name
    self.class.to_s.split("::").last.underscore
  end
  def _interactor
    @interactor ||= ::Conversations::Tags::Interactor.new conversation
  end
end
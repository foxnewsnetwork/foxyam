class Apiv1::Pictures::Presenter
  attr_accessor :interactor
  def initialize(interactor)
    @interactor = interactor
  end

  def conversation_id
    interactor.conversation.id
  end

  def id
    _first_attached_file.id
  end

  def src
    _first_attached_file.the_file.url
  end

  def attributes
    {
      conversation_id: conversation_id,
      id: id,
      source: src
    }
  end

  private
  def _first_attached_file
    @faf ||= interactor.presently_attached_files.first
  end
end
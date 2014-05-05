class FoxYam::SellConversations::Pictures::Interactor < FoxYam::Listings::Pictures::Interactor
  Fields = [
    :pictures
  ].freeze

  delegate :id,
    to: :negotiation

  delegate :attached_files,
    to: :picture

  def the_files
    attached_files.map(&:the_file)
  end
  def negotiation_presenter
    @negotiation_presenter ||= ::Negotiations::ShowPresenter.new negotiation
  end
end
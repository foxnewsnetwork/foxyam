class FoxYam::SellConversations::Pictures::Interactor < FoxYam::Listings::Pictures::Interactor
  Fields = [
    :pictures
  ].freeze

  delegate :id,
    to: :negotiation

  delegate :attached_files,
    to: :picture

  def the_files
    return [] if picture.blank? || attached_files.blank?
    attached_files.map(&:the_file)
  end
  def negotiation_presenter
    @negotiation_presenter ||= ::Negotiations::ShowPresenter.new negotiation
  end
end
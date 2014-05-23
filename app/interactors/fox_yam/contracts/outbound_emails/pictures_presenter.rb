class FoxYam::Contracts::OutboundEmails::PicturesPresenter
  class PicPresenter
    attr_accessor :attachment
    delegate :the_file,
      to: :attachment
    delegate :url,
      to: :the_file
    def initialize(attachment)
      @attachment = attachment
    end
  end
  delegate :offer,
    to: :contract

  delegate :negotiation,
    to: :offer

  delegate :merchant_default_attachments,
    to: :_nego_show_presenter
  attr_accessor :contract
  def initialize(contract)
    @contract = contract
  end

  def pictures
    merchant_default_attachments.map { |a| PicPresenter.new a }
  end

  private
  def _nego_show_presenter
    @nego_show_presenter ||= ::Negotiations::ShowPresenter.new negotiation
  end
end
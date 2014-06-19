class Apiv1::ListingsIndex::Presenter
  attr_accessor :page, :per_page, :merchant
  def initialize(page: page, per_page: per_page, merchant: merchant)
    @page, @per_page = page, per_page
    @merchant = merchant
  end
  def listings
    @presenters ||= _negotiations.map { |n| Apiv1::ListingsIndex::ListingPresenter.new n }
  end
  private
  def _negotiations
    _presenter.negotiations
  end
  def _presenter
    @presenter ||= FoxYam::Buys::Presenter.new merchant
  end
end
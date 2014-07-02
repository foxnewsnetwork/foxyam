class Apiv1::Listings::ShowPresenter < Apiv1::ListingsIndex::ListingPresenter
  def to_builder
    Jbuilder.new do |listing|
      listing.id id
      listing.account_id 1
      listing.conversation_id conversation_id
      listing.created_at created_at
      listing.(self, *Apiv1::Listings::Interactor::Fields)
    end
  end
end
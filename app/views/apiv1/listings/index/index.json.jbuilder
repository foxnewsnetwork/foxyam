json.listings do
  json.partial! partial: 'apiv1/listings/index/listing', collection: presenter.listings, as: :listing
end
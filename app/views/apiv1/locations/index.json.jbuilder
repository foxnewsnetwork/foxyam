json.locations do
  json.partial! partial: 'apiv1/locations/location', collection: presenter.locations, as: :location
end
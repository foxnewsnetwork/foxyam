json.pictures do
  json.partial! partial: 'apiv1/pictures/picture', collection: presenter.presenters, as: :picture
end
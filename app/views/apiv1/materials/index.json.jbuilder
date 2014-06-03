json.materials do
  json.partial! partial: 'apiv1/materials/material', collection: presenter.materials, as: :material
end
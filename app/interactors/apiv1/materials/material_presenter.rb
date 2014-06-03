class Apiv1::Materials::MaterialPresenter

  attr_accessor :material
  delegate :name,
    :description,
    :permalink,
    :id,
    to: :material_description
  def initialize(material)
    @material = material
  end

  def count
    return _count_from_cache if _cache_valid?
    _refresh_count_cache
  end

  def material_description
    @material_description ||= _existing_description || _create_description 
  end

  private
  def _count_from_cache
    material_description.count
  end

  def _refresh_count_cache
    material_description.update(count: _calculate_material_count) && _calculate_material_count
  end

  def _cache_valid?
    _last_same_name_material_created_at.to_i < material_description.updated_at.to_i
  end

  def _last_same_name_material_created_at
    _last_same_name_material.try :created_at
  end

  def _last_same_name_material
    @last_same_name_material ||= _same_name_materials.order("created_at desc").limit(1).first
  end

  def _existing_description
    FoxYam::MaterialDescription.get_by_material material
  end

  def _create_description
    FoxYam::MaterialDescription.create! name: material.material,
      description: 'No description yet...',
      count: _calculate_material_count
  end

  def _calculate_material_count
    @material_count ||= _same_name_materials.count
  end

  def _same_name_materials
    @same_name_materials ||= FoxYam::Conversations::Material.where(material: material.material)
  end
end
class Apiv1::Locations::LocationPresenter

  delegate :permalink,
    :id,
    to: :place
  attr_accessor :place
  
  def initialize(place)
    @place = place
  end

  def location_name
    place.try :name
  end

end
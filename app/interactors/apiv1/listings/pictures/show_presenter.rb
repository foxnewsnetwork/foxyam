class Apiv1::Listings::Pictures::ShowPresenter
  delegate :conversation_id,
    :id,
    to: :picture
  attr_accessor :picture
  def initialize(picture)
    @picture = picture
  end

  def source
    _attached_file.the_file.url
  end

  private
  def _attached_file
    picture.attached_files.first
  end
end
class FoxYam::Listings::Pictures::Interactor < InteractorBase
  Fields = [
    :pictures
  ].freeze
  attr_accessor :conversation, :attributes
  attr_hash_accessor *Fields

  delegate :offer, 
    :negotiation,
    :picture,
    to: :conversation

  delegate :attached_files,
    to: :picture

  delegate :merchant,
    to: :negotiation

  delegate :company,
    to: :offer
  def initialize(conversation)
    @conversation = conversation
  end

  def the_files
    return [] if picture.blank? || attached_files.blank?
    attached_files.map(&:the_file)
  end

  def pictures!
    FoxYam::Merchants::Listings::Result.new valid? && _attached_files
  end
  alias_method :tag!, :pictures!

  def tag
    @picture_tag
  end
  
  def errors_with_attached_files
    return errors_without_attached_files if @attached_files.blank?
    @attached_files.map(&:errors).reduce(errors_without_attached_files) do |accum, error|
      ActiveModel::ErrorsHelper.add accum, error
    end
  end
  alias_method_chain :errors, :attached_files

  private
  def _picture_tag
    @picture_tag ||= conversation.picture || conversation.pictures.create!
  end
  def _attached_files
    @attached_files ||= pictures.map do |picture|
      p = _picture_tag.attached_files.create!
      p.the_file = picture
      p.valid? && p.save && p
    end
  end
end
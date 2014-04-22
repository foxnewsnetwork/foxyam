class Conversations::Tags::Interactor < Conversations::Tags::TagInteractorBase
  MetaFields = [
    :tag_type
  ].freeze
  
  Fields = ( MetaFields +
    Conversations::Tags::QuantityInteractor::Fields +
    Conversations::Tags::OtherInteractor::Fields +
    Conversations::Tags::PackingInteractor::Fields +
    Conversations::Tags::PictureInteractor::Fields +
    Conversations::Tags::MaterialInteractor::Fields +
    Conversations::Tags::PriceInteractor::Fields ).uniq.freeze

  attr_hash_accessor *Fields

  InteractorNames = [
    'quantity',
    'other',
    'packing',
    'picture',
    'price',
    'material'
  ].freeze
  ChildInteractors = InteractorNames.map do |core|
    core.camelcase + 'Interactor'
  end.map do |class_name|
    Conversations::Tags.const_get class_name
  end.freeze

  validates :tag_type,
    presence: true,
    inclusion: { in: InteractorNames }

  def email_text
    Kramdown::Document.new(email.plain_object.raw_source).to_html.html_safe
  end

  def valid_with_remaining_interactors?
    interactors.reduce(valid_without_remaining_interactors?) { |a,b| a && b }
  end
  alias_method_chain :valid?, :remaining_interactors

  def errors_with_remaining_interactors
    interactors.reduce(errors_without_remaining_interactors) { |a,b| _merge a, b.errors }
  end
  alias_method_chain :errors, :remaining_interactors

  def interactors
    ChildInteractors.map do |ic|
      ic.new(conversation).tap { |i| i.attributes = attributes }
    end
  end

  def email_has_pictures?
    email.attached_files.present?
  end

  def email
    conversation.email
  end

  def negotiation
    conversation.negotiation
  end

  private
  def _merge(e1, e2)
    e2.each do |attribute, error|
      e1.add attribute, error
    end
    e1
  end

  def _make_tag
    negotiation.complete! && _appropriate_interactor.tag!
  end

  def _appropriate_interactor
    interactors.find { |i| _tag_type_matches? i }
  end

  def _tag_type_matches?(interactor)
    tag_type.to_s.downcase + '_interactor' == interactor.class.to_s.split("::").last.underscore
  end
end
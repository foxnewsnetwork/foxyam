class Gtps::Contracts::DocumentInteractor < Gtps::Contracts::BaseInteractor
  Fields = [:document_type].freeze
  attr_hash_accessor *Fields
  attr_accessor :document
  validates *Fields,
    presence: true
  validates :document_type,
    inclusion: { in: Gtps::Document::KnownTypes }
  def make!
    _bind_result _valid_with_errors? { _document }
  end
  private
  def _document
    _find_document || _create_document
  end
  def _find_document
    @document ||= contract.documents.find_by_document_type document_type
  end
  def _create_document
    @document ||= contract.documents.create! attributes.permit(*Fields)
  end
end
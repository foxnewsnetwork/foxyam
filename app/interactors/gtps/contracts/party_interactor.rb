class Gtps::Contracts::PartyInteractor < Gtps::Contracts::BaseInteractor
  Fields = [
    :email,
    :company_name,
    :phone_number,
    :address1,
    :address2,
    :city,
    :province,
    :country,
    :party_type
  ].freeze
  attr_hash_accessor *Fields
  attr_accessor :party

  validates :email,
    :company_name,
    :party_type,
    presence: true

  validates :email,
    format: { with: Devise.email_regexp }

  def make!
    _bind_result _valid_with_errors? { _party }
  end
  private
  def _party
    _updated_find_party || _create_party
  end
  def _updated_find_party
    _find_party.try :update, _party_params
    _find_party
  end
  def _find_party
    @party ||= contract.parties.find_by_email email
  end
  def _create_party
    @party ||= contract.parties.create! _party_params
  end
  def _party_params
    attributes.permit *Fields
  end
end
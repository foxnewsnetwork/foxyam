class FoxYam::Contracts::OutboundEmailPreview < ActionMailer::Preview
  def seller_desires_contract_confirmation
    FoxYam::Contracts::OutboundEmailMailer.seller_desires_contract_confirmation(_request)
  end
  private
  def _request
    _email_object.request
  end
  def _email_object
    @email_object ||= Gtps::EmailObject.find_by_external_name 'Gtps::Contract'
  end
end
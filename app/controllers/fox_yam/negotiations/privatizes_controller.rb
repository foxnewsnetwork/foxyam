class FoxYam::Negotiations::PrivatizesController < FoxYam::Negotiations::PublicizesController
  private
  def _alter_publicity_status!
    @result = _negotiation.update public_at: nil
  end
end
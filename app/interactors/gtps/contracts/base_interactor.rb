class Gtps::Contracts::BaseInteractor < InteractorBase
  attr_accessor :contract,:attributes, :result
  def initialize(contract=nil)
    @contract = contract
  end

  private
  def _valid_with_errors?(&block)
    return yield if block_given? && valid?
    errors
  end

  def _bind_result(r)
    self.result = Gtps::Result.new r
  end
end
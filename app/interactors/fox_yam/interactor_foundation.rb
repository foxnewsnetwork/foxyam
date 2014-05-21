class FoxYam::InteractorFoundation < InteractorBase
  attr_accessor :result
  def errors_collection
    FoxYam::Errors.new errors
  end

  private
  def _bind_result(result)
    unbound_result = FoxYam::ResultFoundation.consider_unbind result
    @result = FoxYam::ResultFoundation.new errors_collection, unbound_result 
  end
end
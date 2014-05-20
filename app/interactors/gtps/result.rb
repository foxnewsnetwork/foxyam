class Gtps::Result < FoxYam::ResultBase
  delegate :messages,
    :full_messages,
    to: :thing
  def failed?
    thing.is_a?(ActiveModel::Errors) && thing.any?
  end

  def success?
    !failed?
  end
  
  def payload
    success? && thing
  end

  def errors
    failed? && thing
  end

  def present?
    success?
  end

  def blank?
    failed?
  end
end
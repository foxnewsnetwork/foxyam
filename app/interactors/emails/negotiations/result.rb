class Emails::Negotiations::Result

  def initialize(something)
    @something = something
  end

  def success?
    !error?
  end

  def error?
    @something.blank?
  end

end
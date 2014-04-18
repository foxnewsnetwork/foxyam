class Negotiations::EmailCompanies::Result
  def initialize(thing)
    @thing = thing
  end

  def success?
    @thing.present?
  end
end
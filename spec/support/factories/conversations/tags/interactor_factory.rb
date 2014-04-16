class Factories::Conversations::Tags::Interactor

  def conversation
    @conversation ||= interactor.conversation! && interactor.conversation
  end

  def interactor
    raw_interactor.tap { |i| i.attributes = params }
  end

  def raw_interactor
    @interactor ||= Conversations::Companies::Interactor.new old_conversation
  end

  def old_conversation
    Factories::Conversations::Companies::Interactor.new.conversation
  end

  def params
    {
      company_name: Faker::Company.name,
      offer_type: :sell
    }
  end
end
class Factories::Conversations::Companies::Interactor

  def raw_interactor
    @raw_interactor ||= Emails::Negotiations::Interactor.new email, merchant
  end

  def conversation
    @conversation ||= interactor.negotiation! && interactor.conversation
  end

  def interactor
    raw_interactor.tap { |i| i.attributes = params }
  end

  def email
    envelope.email
  end

  def envelope
    origin.envelope
  end

  def origin
    @origin ||= Factories::Envelopes::Origin.mock
  end

  def merchant
    account.merchant
  end

  def account
    inbox.account
  end

  def inbox
    email.inbox
  end

  def params
    @params ||= { permalink: :new }
  end
end
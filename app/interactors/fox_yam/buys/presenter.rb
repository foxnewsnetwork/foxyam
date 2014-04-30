class FoxYam::Buys::Presenter

  def materials
    @materials ||= _unique_materials.order('material desc')
  end

  def negotiations
    @negotiations ||= _unfinalized_public_negotiations.order('updated_at desc')
  end

  def negotiation_presenters
    @negotiation_presenters ||= negotiations.map do |negotiation|
      Negotiations::ShowPresenter.new negotiation
    end
  end

  private
  def _unique_materials
    @unique_materials ||= FoxYam::Conversations::Material.unique_materials
  end

  def _unfinalized_public_negotiations
    @unfinalized_public_negotiations ||= FoxYam::Negotiation.publicly_available.unfinalized.alive.completed.buy_type
  end
end
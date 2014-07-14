Foxfire.Sitemap.draw ->
  @route("index").you-find("listings").to-the-east!
  @route("index").you-find("listings.index").to-the-east!
  @route("index").you-find("account.index").to-the-north!
  @route("index").you-find("sessions.new").to-the-south!

  @route("listings").you-find("listing.show").to-the-east!
  @route("listings.index").you-find("listing.show").to-the-east!
  @route("listings").you-find("materials.search").to-the-east!
  @route("listings.index").you-find("materials.search").to-the-east!
  @route("listing.show").you-find("listing.offers.index").to-the-east!
  @route("listing.show").you-find("listing.edit").to-the-south!
  @route("listing.offers.index").you-find("listing.edit").to-the-south!
  @route("listing.offers.index").you-find("listing.offers.new").to-the-east!
  @route("listing.offers.index").you-find("offer.show").to-the-east!
  
  @route("sessions.new").you-find("registrations.new").to-the-east!

  @route("offer.show").you-find("offer.accept").to-the-north!
  @route("offer.show").you-find("offer.cancel").to-the-south!
  @route("offer.show").you-find("offer.counter").to-the-east!
  @route("offer.show").you-find("offer.contacts").to-the-east!

  @route("account.index").you-find("account.purchases").to-the-east!
  @route("account.index").you-find("account.sells").to-the-east!
  @route("account.purchases").you-find("account.sells").to-the-east!
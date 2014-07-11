Foxfire.Sitemap.draw ->
  @route("index").you-find("listings").to-the-east!
  @route("index").you-find("listings.index").to-the-east!
  @route("index").you-find("account.show").to-the-south!

  @route("listings").you-find("listing.show").to-the-east!
  @route("listings.index").you-find("listing.show").to-the-east!
  @route("listing.show").you-find("listing.offers").to-the-east!
  @route("listing.show").you-find("listing.edit").to-the-south!

  @route("listing.offers").you-find("listing.offers.new").to-the-east!
  @route("listing.offers").you-find("offer.show").to-the-east!
  
README
=

This is my personal software for doing international mercantile trade in plastics. Named after Fu Xue Yan, the great Chinese merchant and philantrophist of the late Qing dynasty.

Workout Routine
=
(Do it everyday!)
- 3x8 pushups
- 3x8 pullups
- 3x30sec handstands
- 3x8 dips
- 1x120s C sits
- 1x64 flutter kicks
- 1x64 scissors kicks
- 1x120s low planck
- 2x120s side plancks
- 3x30s L sits
- 3x12 V crunches
- 3x8 upside down leg raises
- 1x8 swiss ball rolls
- 1x8 ab wheel rolls
- 3x8 squats
- 3x8 pistol squats

Economic Topics
=
1. The cost of having more choices (as in, giving people choices has a cost)


Design Specifications
=
What should this site do?
- Main usage
1. Pull emails from any email account provided by the user and classify into negotiations
2. Allow users to reply to emails using various canned responses in batches
3. Maintain a collection of companies for each merchant that makes suggestions for offers

ToDos
=
3. refine filing system for income emails, still need automation
5. negotiation show page, fix the t(:need_buyer) junk
6. finalize negotiation button and page
9. request quote implementation
11. user account show page
12. site preferences show page
13. email preferences show page
16. favicon.ico
19. anon_listings and anon_wishlists
20. fork listing
21. connect in email and notify people after making new listing
22. bug reports model, controllers, and whatnot
24. work in pagination
25. permission system stills to be implemeneted across all the other controllers
26. unauthorized.html.haml page
27. uniformize picture size to get proper alignment
28. deaths, revives, publicize, and privateize should all have permission implemented
29. Get rid of Devise in favor of sorcery
30. document and write out workflow based integration testing

Monads, Functors, and Applicatives
=
Consider the following:

```Haskell
instance Functor Promise where
  fmap :: (a -> b) -> Promise a -> Promise b
  fmap f pa = pa `then` (\a -> f a)

instance (Functor Promise) => Applicative Promise where
  pure :: a -> Promise a
  pure a = new Promise (\resolve -> resolve a)

  <*> :: Promise (a -> b) -> Promise a -> Promise b
  pf <*> pa = pf `then` (\f -> fmap f pa)

then :: Promise a -> (a -> b) -> Promise b

```
Tasks
=
Sunday Jun 15
+ upgrade rspec
+ rework negotiations#new to include an ability to connect to email account and alert contacts
+ rework negotiations/offers#new should generate email
+ introduce a footer for logged in accounts
+ when folks make offers, they should send more formal docs
+ When new users make an account, automatically make a company contact info thing
+ merchant user registration path
+ purchase order line items
+ sales order mirror
+ purchase order and sales order into contract
+ workflow as anonymous user coming to site for first time to buy something
+ negotiation finalize deal

Friday Jun 13
- new negotiation submission

Thursday Jun 12
- shitty bug
Wedneday Jun 11
P(V/A) = P(A/V)P(V) / P(A) where P(A) = P(A/V)P(V) + P(A/~V)p(~V)
P(A/V) = 0.95, P(V) = 0.01, P(A/~V) = 0.1, P(~V) = 0.99
P(V/A) = 0.087
P(V/B) = 0.153

Tuesday Jun 10
- More validators
- work in ember test framework

Monday Jun 9
- ember validators and whatnot
- Time inteval field
Friday Jun 6
- new listing submissions, wrote out apiv1/listings/interactor, but missing tests and whatnot

Thursday Jun 5
-  still new listings
Wednesday Jun 4
- still new listings


Tueday Jun 3
- two-thirds through negotiations#new

Monday Jun 2
- midway through negotiations#new

Friday May 30
- certifcate tls issue again

Thursday May 29
- upgrade to 4.1
- FoxYam::Contracts::OutboundEmails::Interactor#outbound_email! now works

Wednesday May 28
- redis resque implemented for scrap and other thing

Tuesday May 27
- email queue, email archive


Friday May 23
- after finalization of offer need contract and outgoing email thing

Thursday May 22
- Gtps::PreviewContracts::Presenter unfilled methods need to get filled

Wednesday May 21
- still working on contract preview

Tuesday May 20
- basic validations on making contracts. Need to customize it later for better messages though
- contracts documents, items, party, punishments, transportation_reqs

Thursday May 15


Tuesday May 13
- finalize negotiation into purchase order

Monday May 12
## TODO

## Thoughts


Friday May 9
- Nothing, just went to town

Thursday May 8
- clean out the db and rework a proper fixture system for testing (incoporated integration testing)
- workflow for existing users to create listings and make offers done

Wednesday May 7
- permission system (started out)


Tuesday May 6
- offer show
- negotiation #mark dead
- footer

Monday May 5
- negotiation make offer (split up FoxYam::Negotiations::SellOffers::Interactor and make it also generate an email)
- negotiation show issue and offer consistency


Friday May 2
- rework negotiation page so that when the merchant's own company offers a price it is displayed as asking price
- purchase wishlist

Thursday May 1
- negotiation mark public
- negotiation_type should be implemented on the negotiation interactors
- public / private selection in negotiations
- fix bug where buys and sells index have their entires flipped

Wednesday April 30
- negotiations new

Tuesday April 29
- home page
- buy index
- sell index
- conversations tags material tags need to have place worked in the view and interactor

Monday April 28
- home page
- navigation header alteration
- Company show page


Friday April 25
- Split up envelope serialization; occasionally, this would be too big and too problematic to just store as a blob

Thursday April 24
- Run through integration test and figure out what needs work
- First stopping block is the lack of resque to incrementally scrap data from google which provides for godawful UX
- Also problem with envelop serialization

Wednesday April 23
- build a better usability test system that spams out emails to mine and whatnot...
- works locally now!
- merchant show page

Tuesday April 22
- pay chase bills
- negotiations show
- conversation pictures index page

Monday April 21
- conversation pictures done, but the index page still needs owkr

Friday April 18
- waste time w/json and alex

Thursday April 17
- Do a write up for all the things that still need to be done
- Finish the existing negotiation edit + update philantrophist

Wednesday April 16
- Got the interactors for new email to negotiation path working

Tuesday April 15
- wasted tons of time in LA

Monday April 14
- got tests and junk working

Friday April 11
- emails and whatnot tied correctly, then remigrated database to get rid of unique index on inbox email address

Thursday April 10
- add new buyer path from negotiation

Monday April 7
- negotiation show now correctly shows material information

Friday April 4
- scaffolded out email to internal representation stuff

Friday March 28
- scaffolded out views

Horror Creepypasta
=
# Characters
1. narrator
2. the lord of the manor - 

# Content
Several decades ago, while I was in college, I experienced first hand what most of you would label as creepy pasta material. In those days, my family was rather poor, but I had managed to earn quite a good bit of money doing some not so proud of things that irked my poor but proud parents and siblings. So when the semester was out, I decided to go on a study abroad exchange program instead of going home.

Assuming none of you really care about all the non-creepypasta back story （not that I remember）, I will just get to the point. I found myself living in a room in a shared house （mansion, really）with a rather rich but supposedly cursed family.

Supposedly, some time ago, a particularly nasty murderer hailed from this family and, ever since, some wild strain of madness and death seems to have stained them.

But the family owned large amounts of land and were wealthy so some hocus pocus about curses in familial history didn't particularly deter that many people from interacting with nor, I suppose, keep the family from enjoying their lives.

Nonetheless, they weren't nice people by any means... at least not to me. I remember the first day I had met the lord of the house in his study. The midaged man strongly built ex soldier had a cigar in his mouth and curling mustaches had said to me flatly, "so you're the one the exchange sent over? Well, I don't like you much." Then he had his butler show me back to my quarters.

Back in my room, the butler gave me some last minute instructions
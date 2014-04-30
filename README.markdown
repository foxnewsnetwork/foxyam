README
=

This is my personal software for doing international mercantile trade in plastics. Named after Fu Xue Yan, the great Chinese merchant and philantrophist of the late Qing dynasty.


Design Specifications
=
What should this site do?
- Main usage
1. Pull emails from any email account provided by the user and classify into negotiations
2. Allow users to reply to emails using various canned responses in batches
3. Maintain a collection of companies for each merchant that makes suggestions for offers

ToDos
=
1. Scrap needs to be not as heavy as it currently is as even retrieving some 50 emails from gmail crashes my system
2. Setup resque to handle scrap requests (as in rework scrap so that it happens as a background process automatically)
3. refine filing system for income emails, still need automation
4. more interactor tests
5. negotiation show page, fix the t(:need_buyer) junk
7. finalize negotiation button and page
8. permission system
9. negotiation #mark dead
10. negotiation finalize deal
11. request quote implementation
12. rework negotiations?buyer seller and offers
14. user account show page
15. site preferences show page
16. email preferences show page
17. Move all the controllers and interactors into the fox_yam namespace
18. Implement a gmail scrapping off of resque requests
19. buy index
20. sell index
21. home page
22. favicon.ico
23. conversations tags material tags need to have place worked in the view and interactor
24. negotiation_type should be implemented on the negotiation interactors
25. footer

Tasks
=
Tuesday April 29
- home page
- buy index
- sell index
+ negotiations new
+ finalize negotiation into contract

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
default: bundle foodcritic integration

bundle:
	bundle install

foodcritic:
	thor foodcritic:lint --epic-fail any

integration:
	kitchen test -p --destroy=always

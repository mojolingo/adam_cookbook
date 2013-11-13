default: bundle foodcritic integration

bundle:
	bundle update

foodcritic:
	thor foodcritic:lint --epic-fail any

integration:
	kitchen test -p --destroy=always

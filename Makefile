default: bundle update_cookbooks foodcritic integration

bundle:
	bundle update

update_cookbooks:
	berks update

foodcritic:
	thor foodcritic:lint --epic-fail any

integration:
	kitchen test -p --destroy=always

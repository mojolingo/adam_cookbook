# Adam Snark Rabbit cookbook

This Chef cookbook installs Mojo Lingo's Adam Snark Rabbit intelligent assistant.

# Requirements

Tested on Ubuntu 12.04.

# Usage

Add `recipe[adam_snark_rabbit]` to your node's run list

# Attributes

# Recipes

* `adam_snark_rabbit` - Deploys all default components of Adam to the same box

# Testing

In order to run tests (using Test Kitchen) you will need to place a deploy key for Adam Rabbit in `./deploy_key`. You can then run the full test suite using `make`.

# Author

[Ben Langfeld](@benlangfeld)

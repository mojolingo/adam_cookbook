# Adam Snark Rabbit cookbook

This Chef cookbook installs Mojo Lingo's Adam Snark Rabbit intelligent assistant.

# Requirements

Tested on Ubuntu 12.04 and Debian 7.

# Usage

Add `recipe[adam_snark_rabbit]` to your node's run list to install all Adam components to a single machine. Make sure to set all required attributes below.

Alternatively select appropriate recipes for individual components for distributed deployment.

# Recipes

* `adam_snark_rabbit`               - Deploys all default components of Adam to the same box
* `adam_snark_rabbit::base`         - Sets up base system requirements for deployment of Adam Snark Rabbit components
* `adam_snark_rabbit::app`          - Deploys the selected application components of Adam Snark Rabbit
* `adam_snark_rabbit::mongo`        - Installs MongoDB for use by Adams Memory
* `adam_snark_rabbit::rabbitmq`     - Install RabbitMQ, Adams nervous system
* `adam_snark_rabbit::rayo`         - Installs a Rayo server for use by Adam to provide the Ears service
* `adam_snark_rabbit::remove_dash`  - Removes Dash as the default shell from Ubuntu due to incompatability with POSIX sh
* `adam_snark_rabbit::user`         - Sets up the Adam user
* `adam_snark_rabbit::xmpp`         - Installs an XMPP server for use by Adam components including Fingers

# Attributes

# Testing

In order to run tests (using Test Kitchen) you will need to place a deploy key for Adam Rabbit in `./deploy_key`. You can then run the full test suite using `make`.

# Author

[Ben Langfeld](@benlangfeld)

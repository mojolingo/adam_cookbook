# Adam Snark Rabbit cookbook

This Chef cookbook installs Mojo Lingo's Adam Snark Rabbit intelligent assistant.

# Requirements

Tested on Ubuntu 12.04 and Debian 7.

# Usage

Add `recipe[adam_snark_rabbit]` to your node's run list to install all Adam components to a single machine. Make sure to set all required attributes below.

Alternatively select appropriate recipes for individual components for distributed deployment.

# Recipes

<table>
  <thead>
    <tr>
      <th>Recipe</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>adam_snark_rabbit</td>
      <td>
        Deploys all default components of Adam to the same box
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::base</td>
      <td>
        Sets up base system requirements for deployment of Adam Snark Rabbit components
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::app</td>
      <td>
        Deploys the selected application components of Adam Snark Rabbit
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::mongo</td>
      <td>
        Installs MongoDB for use by Adams Memory
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::xmpp</td>
      <td>
        Installs an XMPP server for use by Adam components including Fingers
      </td>
    </tr>
  </tbody>
</table>

# Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>adam/environment</td>
      <td>
        The environment in which to run Adam's application components. Affects logging, defaults settings, etc.
      </td>
      <td>"production"</td>
    </tr>
    <tr>
      <td>adam/deployment_path</td>
      <td>
        The path at which to deploy Adam's application components.
      </td>
      <td>"/srv/adam"</td>
    </tr>
default['adam']['repo']['email']          = '.'
default['adam']['repo']['username']       = nil
default['adam']['repo']['password']       = nil
    <tr>
      <td>adam/repo/domain</td>
      <td>
        The URL of the repo from which to clone Adam's components.
      </td>
      <td>"quay.io"</td>
    </tr>
    <tr>
      <td>adam/repo/tag</td>
      <td>
        The repository reference to checkout for deployment. The default of "latest" provides the latest changes to Adam.
      </td>
      <td>"latest"</td>
    </tr>
    <tr>
      <td>adam/repo/email</td>
      <td>
        The email address for the account with which to clone the Adam Snark Rabbit components for deployment.
      </td>
      <td>'.'</td>
    </tr>
    <tr>
      <td>adam/repo/username</td>
      <td>
        The username for the account with which to clone the Adam Snark Rabbit components for deployment.
      </td>
      <td>nil</td>
    </tr>
    <tr>
      <td>adam/repo/password</td>
      <td>
        The password for the account with which to clone the Adam Snark Rabbit components for deployment.
      </td>
      <td>nil</td>
    </tr>
    <tr>
      <td>adam/root_domain</td>
      <td>
        The root domain of the Adam deployment. This is particularly for XMPP JIDs.
      </td>
      <td>`node['fqdn']`</td>
    </tr>
    <tr>
      <td>adam/memory_base_url</td>
      <td>
        The base address at which to access Adam's Memory component. This is used for XMPP authentication and authenticating messages received from senses by the Brain.
      </td>
      <td>'http://localhost'</td>
    </tr>
    <tr>
      <td>adam/reporter/url</td>
      <td>
        The exception reporter URL to use.
      </td>
      <td>"http://errors.mojolingo.com"</td>
    </tr>
    <tr>
      <td>adam/reporter/api_key</td>
      <td>
        The exception reporter API key.
      </td>
      <td>""</td>
    </tr>
    <tr>
      <td>adam/wit_api_key</td>
      <td>
        The API key for Wit (semantic interpretation of messages) connectivity.
      </td>
      <td>""</td>
    </tr>
    <tr>
      <td>adam/brain/install</td>
      <td>
        Wether or not to install the Brain on this node.
      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/memory/install</td>
      <td>
        Wether or not to install Memory on this node.
      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/memory/internal_username</td>
      <td>
        The internal username with which to authenticate Adam's components against Memory.
      </td>
      <td>'internal'</td>
    </tr>
    <tr>
      <td>adam/memory/internal_password</td>
      <td>
        The internal password with which to authenticate Adam's components against Memory.
      </td>
      <td>'abc123'</td>
    </tr>
    <tr>
      <td>adam/memory/mongoid_host</td>
      <td>
        The host on which MongoDB is running for data storage.
      </td>
      <td>'127.0.0.1'</td>
    </tr>
    <tr>
      <td>adam/memory/bosh_host</td>
      <td>
        The host to which BOSH (XMPP) requests should be forwarded from the reverse proxy. This should be the host on which the XMPP server is running.
      </td>
      <td>'localhost'</td>
    </tr>
  </tbody>
</table>

# Testing

In order to run tests (using Test Kitchen) you will need to place credentials for Adam Rabbit in `.kitchen.local.yml` with the following format. You can then run the full test suite using `make`.

```yaml
---
suites:
- name: default
  run_list: ['recipe[adam_snark_rabbit]']
  attributes:
    adam:
      repo:
        email: foo@bar.com
        username: foobar
        password: abc123
```

# Author

[Ben Langfeld](@benlangfeld)

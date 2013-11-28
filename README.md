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
      <td>adam_snark_rabbit::rabbitmq</td>
      <td>
        Install RabbitMQ, Adams nervous system
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::rayo</td>
      <td>
        Installs a Rayo server for use by Adam to provide the Ears service
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::remove_dash</td>
      <td>
        Removes Dash as the default shell from Ubuntu due to incompatability with POSIX sh
      </td>
    </tr>
    <tr>
      <td>adam_snark_rabbit::user</td>
      <td>
        Sets up the Adam user
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
      <td>adam/standalone_deployment</td>
      <td>

      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/deployment_path</td>
      <td>

      </td>
      <td>"/srv/adam"</td>
    </tr>
    <tr>
      <td>adam/app_repo_url</td>
      <td>

      </td>
      <td>"git@github.com:mojolingo/Adam.Snark.Rabbit.git"</td>
    </tr>
    <tr>
      <td>adam/app_repo_ref</td>
      <td>

      </td>
      <td>"master"</td>
    </tr>
    <tr>
      <td>adam/root_domain</td>
      <td>

      </td>
      <td>`node['fqdn']`</td>
    </tr>
    <tr>
      <td>adam/memory_base_url</td>
      <td>

      </td>
      <td>'http://localhost'</td>
    </tr>
    <tr>
      <td>adam/amqp_host</td>
      <td>

      </td>
      <td>'localhost'</td>
    </tr>
    <tr>
      <td>adam/rayo_domain</td>
      <td>

      </td>
      <td>`node['adam']['root_domain']`</td>
    </tr>
    <tr>
      <td>adam/reporter/url</td>
      <td>

      </td>
      <td>"http://errors.mojolingo.com"</td>
    </tr>
    <tr>
      <td>adam/reporter/api_key</td>
      <td>

      </td>
      <td>""</td>
    </tr>
    <tr>
      <td>adam/wit_api_key</td>
      <td>

      </td>
      <td>""</td>
    </tr>
    <tr>
      <td>adam/brain/install</td>
      <td>

      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/ears/install</td>
      <td>

      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/ears/punchblock_port</td>
      <td>

      </td>
      <td>5222</td>
    </tr>
    <tr>
      <td>adam/fingers/install</td>
      <td>

      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/memory/install</td>
      <td>

      </td>
      <td>true</td>
    </tr>
    <tr>
      <td>adam/memory/internal_username</td>
      <td>

      </td>
      <td>'internal'</td>
    </tr>
    <tr>
      <td>adam/memory/internal_password</td>
      <td>

      </td>
      <td>'abc123'</td>
    </tr>
    <tr>
      <td>adam/memory/mongoid_host</td>
      <td>

      </td>
      <td>'127.0.0.1'</td>
    </tr>
    <tr>
      <td>adam/memory/bosh_host</td>
      <td>

      </td>
      <td>'localhost'</td>
    </tr>
    <tr>
      <td>adam/memory/application_servers</td>
      <td>

      </td>
      <td>`['127.0.0.1']`</td>
    </tr>
    <tr>
      <td>adam/rayo/listeners</td>
      <td>

      </td>
      <td>
        ```
        [
          {
            'type' => "c2s",
            'port' => "5222",
            'address' => "$${rayo_ip}",
            'acl' => ""
          },
          {
            'type' => "c2s",
            'port' => "5222",
            'address' => "127.0.0.1",
            'acl' => ""
          }
        ]
        ```
      </td>
    </tr>
  </tbody>
</table>

# Testing

In order to run tests (using Test Kitchen) you will need to place a deploy key for Adam Rabbit in `./deploy_key`. You can then run the full test suite using `make`.

# Author

[Ben Langfeld](@benlangfeld)

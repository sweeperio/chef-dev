# dev

A cookbook for setting up and configuring dev machines.

## Attributes

Attribute|Description|Default
---------|-----------|-------
`node["dev"]["database_user"]` | Username to be created for installed databases | `vagrant`
`node["dev"]["database_password"]` | Password for database_user | `developerPassword1`
`node["dev"]["gems"]` | A list of gems to be installed for each version of ruby | `%w(bundler)`
`node["dev"]["packages"]` | The set of apt packages to install | `%w(curl silversearcher-ag)`
`node["dev"]["vagrant_shell"]` | The default shell for the vagrant user | `bash`

### Default Chruby Settings

See [chruby cookbook] for options.

Attribute|Description|Default
---------|-----------|-------
`node["chruby"]["auto_switch"]` | Use .ruby-version file for switching | `true`
`node["chruby"]["default"]` | The default version of ruby | `2.2.3`
`node["chruby"]["rubies"]` | A hash of ruby versions to be installed/skipped | `2.1.7 and 2.2.3`

[chruby cookbook]: https://github.com/Atalanta/chef-chruby

### Default Memcached Settings

See [memcached cookbook] for options.

Attribute|Description|Default
---------|-----------|-------
`node["memcached"]["listen"]` | The address to listen on | `127.0.0.1`

[memcached cookbook]: https://github.com/chef-cookbooks/memcached

### Default Nodejs Settings

See [nodejs cookbook] for options.

Attribute|Description|Default
---------|-----------|-------
`node["nodejs"]["npm_packages"]` | Global npm packages to be installed | `coffee-script and grunt-cli`

[nodejs cookbook]: https://github.com/redguide/nodejs

### Default Tmux Settings

See [tmux cookbook] for options

Attribute|Description|Default
---------|-----------|-------
`node["tmux"]["install_method"]` | How to install tmux | `source`

[tmux cookbook]: https://github.com/stevendanna/tmux

## Doing Things

To do any of these things, you'll need [ChefDK] and [Vagrant] installed.

* Lint: `chef exec rubocop`
* Run Specs: `chef exec rspec`
* Run Integration Tests: `chef exec kitchen test` (will destroy and recreate box)

It's faster to run `chef exec kitchen converge && chef exec kitchen verify` while developing. Just make sure to run test
on a clean box before pushing.

[ChefDK]: https://downloads.chef.io/chef-dk/
[Vagrant]: https://www.vagrantup.com/

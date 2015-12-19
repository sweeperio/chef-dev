# dev

A cookbook for setting up and configuring dev machines.

## What Does it Do?

* Adds a `sudoers` group (with sudo access) and adds `vagrant` to it
* Installs a few apt packages, including build-essential (see attributes)
* Installs ruby `2.1.7` and `2.2.3` (defaulted to `2.2.3` with chruby)
* Installs gems defined in `node["dev"]["gems"]` for all installed ruby versions (see attributes)
* **If postgresql is installed**, creates a user account for vagrant

### Applications

* [chruby] - default set to `2.2.3` with auto switch enabled
* [fasd]
* [node] - with coffee-script and grunt-cli installed globally
* [phantomjs]
* [vim] - Compiled from source with ruby and python support
* [tmux]

[chruby]: https://github.com/postmodern/chruby
[fasd]: https://github.com/clvv/fasd
[node]: https://nodejs.org/
[phantomjs]: http://phantomjs.org/
[vim]: http://www.vim.org/
[tmux]: https://tmux.github.io/

### Services

* [memcached] - configured to listen on `127.0.0.1` only
* [nginx] - open resty with a default server listening on port `80` (proxy passes to `localhost:3000` because [Rails])
* [redis] - on the default port (also installs `redis-cli`)

[memcached]: http://memcached.org/
[nginx]: https://openresty.org/
[Rails]: http://rubyonrails.org/
[redis]: http://redis.io/

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

### Default Sudo Settings

See [sudo cookbook] for options.

Attribute|Description|Default
---------|-----------|-------
`node["authorization"]["sudo"]["groups"]` | Groups to enable sudo access for | `%w(sudoers)`
`node["authorization"]["sudo"]["passwordless"]` | Whether or not to require passwords for sudo | `false`

[sudo cookbook]: https://github.com/chef-cookbooks/sudo

### Default Tmux Settings

See [tmux cookbook] for options

Attribute|Description|Default
---------|-----------|-------
`node["tmux"]["install_method"]` | How to install tmux | `source`

[tmux cookbook]: https://github.com/stevendanna/tmux

## Contributing

To do any of the things, you'll need [ChefDK] and [Vagrant] installed.

* Lint: `chef exec rubocop`
* Run Specs: `chef exec rspec`
* Run Integration Tests: `chef exec kitchen test` (will destroy and recreate box)

It's faster to run `chef exec kitchen converge && chef exec kitchen verify` while developing. Just make sure to run test

### The Rest, You Already Know

1. Fork this repo and create a branch
1. Add tests that will fail without your code, and pass with it
1. Use Chef idioms and helpers
1. Push your branch and submit a pull request
on a clean box before pushing.

[ChefDK]: https://downloads.chef.io/chef-dk/
[Vagrant]: https://www.vagrantup.com/

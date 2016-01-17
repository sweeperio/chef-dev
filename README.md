# swpr_dev

[![Build Status](https://travis-ci.org/sweeperio/chef-swpr_dev.svg?branch=master)](https://travis-ci.org/sweeperio/chef-swpr_dev)

Install/configure a kick-ass dev machine!

## What This Does

* Installs [hub] for the greater good
* Installs nginx with open resty and a default config for rails apps (upstream for localhost:3000)
* Makes and installs tmux from source (see attributes)
* Makes and installs vim from source (see attributes)
* Installs zsh
* Sets the default shell for vagrant user (see attributes)
* Installs memcached
* Installs redis
* Installs the Heroku toolbelt
* Installs postgresql 9.3 (if the `postgresql` recipe is included)
* Installs latest stable release of rust (if the `rustlang` recipe is included)
* Installs golang and associated packages (if the `golang` recipe is included)
* Installs nodejs and global packages (if the `nodejs` recipe is included)

[hub]: https://github.com/github/hub

## Attributes

| attribute | description | default |
|-----------|-------------|---------|
| `node["swpr_dev"]["hub"]["version"]` | the version of hub to install | `2.2.2` |
| `node["swpr_dev"]["db"]["user"]` | database user for development | `vagrant` |
| `node["swpr_dev"]["db"]["password"]` | password for the database user | `developerPassword1` |
| `node["swpr_dev"]["golang"]["go_path"]` | the `GOPATH` directory | `/home/vagrant/go` |
| `node["swpr_dev"]["golang"]["version"]` | the version of go to install | `1.5.3` |
| `node["swpr_dev"]["golang"]["packages"]` | packages to `go get` | `godep and gb` see _attributes/default.rb_ |
| `node["swpr_dev"]["nodejs"]["packages"]` | global node packages to install | `coffee-script, grunt-cli` |
| `node["swpr_dev"]["tmux"]["version"]` | the version of tmux to install | `2.1` |
| `node["swpr_dev"]["vim"]["autoconf_opts"]` | params for the ./configure call for vim | `%w(--enable-pythoninterp
--enable-rubyinterp)` |
| `node["swpr_dev"]["vim"]["version"]` | the version of vim to install | `7-4-658` |
| `node["swpr_dev"]["vagrant_shell"]` | the default shell for the vagrant user | `bash` |

## Recipes

### swpr_dev::default

The main recipe. This does all the things

**Usage:** add `recipe[swpr_dev]` to your run list.

### swpr_dev::postgresql

Installs postgres and sets up some good defaults for dev.

**Usage:** add `recipe[swpr_dev::postgresql]` to your run list.

#### Overridden Attributes (from the postgresql cookbook)

| attribute | default |
|-----------|---------|
| `node["postgresql"]["config"]["listen_addresses"]` | `*` |
| `node["postgresql"]["password"]["postgress"]` | `aad1493719f8846f0360e5dbc7654ac5` |
| `node["postgresql"]["pg_hba"]` | Updated to allow remote connections from `192.168.0.0/16`

### swpr_dev::rustlang

Installs the latest stable release of Rust.

**Usage:** add `recipe[swpr_dev::rustlang]` to your run list.

### swpr_dev::golang

Installs the specified version of golang and `go gets` packages (see attributes above).

**Usage:** add `recipe[swpr_dev::golang]` to your run list.

### swpr_dev::nodejs

Installs node, npm and any packages define in attributes.

**Usage:** add `recipe[swpr_dev::nodejs]` to your run list.

## License

The MIT License (MIT)

Copyright (c) 2016 sweeper.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

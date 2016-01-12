# swpr_dev

[![Build Status](https://travis-ci.org/sweeperio/chef-swpr_dev.svg?branch=master)](https://travis-ci.org/sweeperio/chef-swpr_dev)

Install/configure swpr_dev

## What This Does

* Makes and installs tmux from source (see attributes)
* Makes and installs vim from source (see attributes)
* Installs zsh
* Sets the default shell for vagrant user (see attributes)

## Attributes

| attribute | description | default |
|-----------|-------------|---------|
| `node["swpr_dev"]["tmux"]["version"]` | the version of tmux to install | `2.1` |
| `node["swpr_dev"]["vim"]["autoconf_opts"]` | params for the ./configure call for vim | `%w(--enable-pythoninterp
--enable-rubyinterp)` |
| `node["swpr_dev"]["vim"]["version"]` | the version of vim to install | `7-4-658` |
| `node["swpr_dev"]["vagrant_shell"]` | the default shell for the vagrant user | `base` |

## Recipes

### swpr_dev::default

The main recipe. This does all the things

**Usage:** add `recipe[swpr_dev]` to your run list.

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

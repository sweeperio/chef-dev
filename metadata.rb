# rubocop:disable Style/SingleSpaceBeforeFirstArg
name             "swpr_dev"
maintainer       "sweeper.io"
maintainer_email "developers@sweeper.io"
license          "mit"
description      "Installs/Configures swpr_dev"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"
# rubocop:enable Style/SingleSpaceBeforeFirstArg

supports "ubuntu"

depends "ark",         "~> 0.0"
depends "fasd",        "~> 1.0"
depends "open_resty",  "~> 0.0"
depends "swpr_core",   "~> 0.0"

chef_version ">= 12.5" if respond_to?(:chef_version)
source_url "https://github.com/sweeperio/chef-swpr_dev" if respond_to?(:source_url)
issues_url "https://github.com/sweeperio/chef-swpr_dev/issues" if respond_to?(:issues_url)

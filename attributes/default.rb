default["swpr_dev"]["hub"]["version"] = "2.2.2"

default["swpr_dev"]["db"]["user"]     = "vagrant"
default["swpr_dev"]["db"]["password"] = "developerPassword1"

default["swpr_dev"]["golang"]["go_path"] = "/home/vagrant/go"
default["swpr_dev"]["golang"]["version"]  = "1.5.3"
default["swpr_dev"]["golang"]["packages"] = %w(
  github.com/tools/godep
  github.com/constabulary/gb/...
)

default["swpr_dev"]["nodejs"]["packages"] = %w(coffee-script grunt-cli)

default["swpr_dev"]["tmux"]["version"] = "2.1"

default["swpr_dev"]["vagrant_shell"]   = "bash"

default["swpr_dev"]["vim"]["version"]       = "7-4-658"
default["swpr_dev"]["vim"]["autoconf_opts"] = %w(--enable-pythoninterp --enable-rubyinterp)

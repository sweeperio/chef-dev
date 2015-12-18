# dev

## Doing Things

To do any of these things, you'll need [ChefDK] and [Vagrant] installed.

* Lint: `chef exec rubocop`
* Run Specs: `chef exec rspec`
* Run Integration Tests: `chef exec kitchen test` (will destroy and recreate box)

It's faster to run `chef exec kitchen converge && chef exec kitchen verify` while developing. Just make sure to run test
on a clean box before pushing.

[ChefDK]: https://downloads.chef.io/chef-dk/
[Vagrant]: https://www.vagrantup.com/

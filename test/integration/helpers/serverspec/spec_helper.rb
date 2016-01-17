require "serverspec"

set :backend, :exec
set :os, family: "ubuntu", release: "14.04", arch: "x86_64"

def pg_role(role)
  %(sudo -u postgres psql -c "SELECT rolname FROM pg_roles WHERE rolname='#{role}'" | grep #{role})
end

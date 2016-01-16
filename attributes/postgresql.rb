default["postgresql"]["config"]["listen_addresses"] = "*"

default["postgresql"]["password"]["postgres"] = "aad1493719f8846f0360e5dbc7654ac5"

default["postgresql"]["pg_hba"] = [
  { type: "local", db: "all", user: "postgres", addr: "", method: "ident" },
  { type: "local", db: "all", user: "all", addr: "", method: "ident" },
  { type: "host", db: "all", user: "all", addr: "127.0.0.1/32", method: "md5" },
  { type: "host", db: "all", user: "all", addr: "::1/128", method: "md5" },
  { type: "host", db: "all", user: "all", addr: "192.168.0.0/16", method: "trust" }
]

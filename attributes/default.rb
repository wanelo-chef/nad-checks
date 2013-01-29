default["nad_checks"]["pg_replication"]["pg_version"] = "9.2"                       # 9.2 / 9.1

default["nad_checks"]["pg_replication"]["user"] = "postgres"
default["nad_checks"]["pg_replication"]["path_additions"] = %w[/opt/local/bin]

default["nad_checks"]["pg_replication"]["9_1"]["master"]["host"] = nil
default["nad_checks"]["pg_replication"]["9_1"]["replica"]["host"] = "127.0.0.1"


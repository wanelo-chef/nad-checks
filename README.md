nad-checks
==========

## Description

`nad-checks` is a Chef cookbook for installing additional Circonus `nad` checks. `nad` is the `node agent daemon`,
a process that exposes scripts (sh, perl, c, etc) to an external port so that they can be aggregated on a
Circonus enterprise broker.

For more information, see http://circonus.com

## Dependencies

* A way of installing nad. See the metadata file for more info.

## Requirements

This cookbook has only been tested on SmartOS.

## Recipes

### nad-checks::pg_replication

This recipe will install checks for PostgreSQL replication status. It can be applied to a master or a hot standby (depending
on PostgreSQL version), and will provide whatever information it can.

#### Attributes:

  * `nad_checks.pg_replication.pg_version` - Array - 9.2 - the version of Postgres running. This determines what
     types of checks are available.
  * `nad_checks.pg_replication.user` - String - postgres - what user to connect with via psql
  * `nad_checks.pg_replication.path_additions` - Array - /opt/local/bin - update this if your `psql` account is in a
     different directory

#### 9.1 Attributes

  * `nad_checks.pg_replication.9_1.master.host` - String,NilClass - nil - master IP or FQDN to get upstream xlog location
  * `nad_checks.pg_replication.9_1.replica.host` - String - 127.0.0.1 - replica host to get applied xlog location

#### 9.1 Usage

When running against a 9.1 version of Postgres, the easiest application is to set `nad_checks.pg_replication.pg_version`
to `9.1` and apply the recipe to each hot standby. The check will connect the master host to get its current xlog
location, then will connect locally to see the applied xlog location. The provided nad metrics will be:

  * `pg_sql:0:replication:master_xlog` - string - the current xlog on the master
  * `pg_sql:0:replication:replay_xlog` - string - the last applied xlog on the replica
  * `pg_sql:0:replication:bytes_diff` - signed double - number of bytes between `master_xlog` and `replay_xlog`

Note that depending on network settings (as well as the time it takes to run the various checks), `bytes_diff` may be
negative at times.

#### 9.2 Usage

When running a 9.2 version of Postgres, set `nad_checks.pg_replication.pg_version` to `9.2` and apply to all hosts,
including the master. On the master (or hot standbys cascading replication to other standbys), the following metric will
become available for each replication host:

  * `pg_replication:$host:master:xlog_sent_diff` - signed double - bytes different between the xlog sent to the standby and the
    xlog written

On a standby, the following metrics will be available:

  * `pg_replication:0:replica:xlog_applied_diff` - signed double - bytes different between the xlog received and what
    has been successfully applied, is a measure of replication lag in bytes.
  * `pg_replication:0:replica:time_since_commit` - signed double - seconds since the last commit or rollback applied,
    this is a measure of the replication lag in time, though it is not exact.

If `xlog_sent_diff` grows on the master, but `xlog_applied_diff` is low, then this implies that there is latency in the
network. If `xlog_sent_diff` is low but `xlog_applied_diff` is high, then something on the standby is introducing latency
in applying wal logs (such as disk write time or disk wait).

include_recipe "java"
include_recipe "monit"
include_recipe "elasticsearch::default"
# Check whether elasticsearch is running, reachable by HTTP and
# the cluster is in the "green" state
include_recipe "elasticsearch::monit"

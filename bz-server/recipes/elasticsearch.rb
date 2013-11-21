include_recipe "java"
include_recipe "monit"
include_recipe "elasticsearch::default"
include_recipe "elasticsearch::monit" # monitoring

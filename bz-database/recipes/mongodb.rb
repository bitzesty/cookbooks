include_recipe "mongodb"

run_list(
  "recipe[mongodb::10gen_repo]"
)

include_recipe "mongodb::default"

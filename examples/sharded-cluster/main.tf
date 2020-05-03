module "config" {
  source = "../.."

  sharded = true
  shard_count = 3
  member_count = 3
  name = "markbm"
  image_id = "ami-06ce3edf0cff21f07"
  instance_type = "t2.micro"
  domain_name = "example.com"
}

output "data_replica_sets" {
  value = module.config.data_replica_sets
}

output "config_replica_set" {
  value = module.config.config_replica_set
}

output "router_nodes" {
  value = module.config.router_nodes
}
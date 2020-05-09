module "config" {
  source = "../.."

  cohost_routers      = false
  sharded             = true
  shard_count         = 3
  member_count        = 5
  config_member_count = 3
  router_count        = 2
  name                = "example"
  image_id            = "ami-06ce3edf0cff21f07"
  instance_type       = "t2.micro"
}

output "replica_sets" {
  value = module.config.replica_sets
}

output "router_nodes" {
  value = module.config.router_nodes
}
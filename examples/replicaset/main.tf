module "config" {
  source = "../.."

  member_count  = 3
  name          = "markbm"
  image_id      = "ami-06ce3edf0cff21f07"
  instance_type = "t2.micro"
}

output "replica_sets" {
  value = module.config.replica_sets
}
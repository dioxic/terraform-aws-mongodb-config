
variable "name" {
  description = "The cluster name. Required."
}

variable "domain_name" {
  description = "The domain name for the cluster config. Required."
}

variable "config_mongod_port" {
  description = "mongod port for config server, defaults to `27019`."
  type        = number
  default     = 27019
}

variable "sharded_mongod_port" {
  description = "mongod port with sharded topology, defaults to `27018`."
  type        = number
  default     = 27018
}

variable "mongod_port" {
  description = "mongod port with unsharded topology, defaults to `27017`."
  type        = number
  default     = 27017
}

variable "mongos_port" {
  description = "mongos port, defaults to `27017`."
  type        = number
  default     = 27017
}

variable "shard_count" {
  type    = number
  default = 1
}

variable "member_count" {
  type    = number
  default = 3
}

variable "sharded" {
  description = "Defines if this is a sharded cluster, defaults to `false`."
  type    = bool
  default = false
}

variable "cohost_routers" {
  description = "Cohost the routers on the shard servers?, defaults to `true`."
  type    = bool
  default = true
}

variable "router_count" {
  description = "Number of routers to deploy, has no effect if cohosting routers, defaults to `3`."
  type    = number
  default = 3
}

variable "image_id" {
  description = "Machine image for mongodb server hosts. Required."
}

variable "config_image_id" {
  description = "Machine image for config server hosts, defaults to `image_id`."
  default     = null
}

variable "router_image_id" {
  description = "Machine image for router server hosts, defaults to `image_id`."
  default     = null
}

variable "instance_type" {
  description = "AWS instance type for mongodb host (e.g. m4.large), defaults to \"t2.micro\"."
  default     = "t2.micro"
}

variable "config_instance_type" {
  description = "AWS instance type for config server host (e.g. m4.large), defaults to `instance_type`"
  default     = null
}

variable "router_instance_type" {
  description = "AWS instance type for router server host (e.g. m4.large), defaults to `instance_type`."
  default     = null
}

variable "data_block_device_name" {
  description = "Block device name for data, defaults to \"xvdb\""
  default     = "xvdb"
}

variable "data_block_device_volume_type" {
  description = "Volume type for data device, defaults to \"gp2\""
  default     = "gp2"
}

variable "data_block_device_iops" {
  description = "IOPS for data device if using io1 volume type, defaults to `1000`."
  default     = 1000
}

variable "data_block_device_volume_size" {
  description = "Volume size (GB) for data device, defaults to `100`."
  type        = number
  default     = 100
}

variable "data_mount_point" {
  description = "MongoDB data mount point, defaults to \"/data\"."
  default     = "/data"
}
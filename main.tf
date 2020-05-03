
locals {

  default_mongod_node = {
    priority       = 1
    votes          = 1
    hidden         = false
    arbiterOnly    = false
  }

  default_data_node = merge(local.default_mongod_node, {
    mongod_port        = var.sharded ? var.sharded_mongod_port : var.mongod_port
    mongos_port        = var.sharded && var.cohost_routers ? var.mongos_port : null
    image_id           = var.image_id
    instance_type      = var.instance_type
    is_router_node     = var.cohost_routers
    volume_type        = var.data_block_device_volume_type
    volume_size        = var.data_block_device_volume_size
    volume_iops        = var.data_block_device_iops
  })

  default_config_node = merge(local.default_mongod_node, {
    mongod_port        = var.config_mongod_port
    image_id           = coalesce(var.config_image_id, var.image_id)
    instance_type      = coalesce(var.config_instance_type, var.instance_type)
    volume_type        = var.config_block_device_volume_type
    volume_size        = var.config_block_device_volume_size
    volume_iops        = var.config_block_device_iops
  })

  default_router_node = {
    mongos_port    = var.mongos_port
    image_id       = coalesce(var.router_image_id, var.image_id)
    instance_type  = coalesce(var.router_instance_type, var.instance_type)
  }

  data_replica_sets = [
    for i in range(var.sharded ? var.shard_count : 1) : {
      name        = var.sharded ? format("%s-shard-%02d", var.name, i) : "${var.name}-rs"
      shard_name  = var.sharded ? format("shard%d", i) : null
      nodes       = [ for j in range (var.member_count) : merge(local.default_data_node, {
        name     = format("%s-shard-%02d-%02d", var.name, i, j)
        hostname = format("%s-shard-%02d-%02d.%s", var.name, i, j, var.domain_name)
      })]
    }
  ]

  config_replica_set = var.sharded ? {
    name        = format("%s-config", var.name)
    nodes       = [ for i in range (var.member_count) : merge(local.default_config_node, {
      name     = format("%s-config-%02d", var.name, i)
      hostname = format("%s-config-%02d.%s", var.name, i, var.domain_name)
    })]
  } : null

  router_nodes = var.sharded && !var.cohost_routers ? [ for i in range (var.router_count) : merge(local.default_router_node, {
      name     = format("%s-router-%02d", var.name, i)
      hostname = format("%s-router-%02d.%s", var.name, i, var.domain_name)
  })] : null

}

locals {

  default_mongod_node = {
    priority       = 1
    votes          = 1
    hidden         = false
    arbiter_only   = false
  }

  default_data_node = merge(local.default_mongod_node, {
    mongod_port        = var.sharded ? var.sharded_mongod_port : var.mongod_port
    mongos_port        = var.sharded && var.cohost_routers ? var.mongos_port : null
    image_id           = var.image_id
    instance_type      = var.instance_type
    volume_type        = var.data_block_device_volume_type
    volume_size        = var.data_block_device_volume_size
    volume_iops        = var.data_block_device_iops
  })

  default_config_node = merge(local.default_mongod_node, {
    mongod_port        = var.config_mongod_port
    mongos_port        = null
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

  data_replica_sets = {
    for i in range(var.sharded ? var.shard_count : 1) :
      var.sharded ? format("%s-shard-%02d", var.name, i) : "${var.name}-rs" => {
        shard_name    = var.sharded ? format("shard%d", i) : null
        config_server = false
        nodes         = [ for j in range (var.member_count) : merge(local.default_data_node, {
          name          = format("%s-shard-%02d-%02d", var.name, i, j)
        })]
      }
  }

  config_replica_set = var.sharded ? {
    format("%s-config", var.name) = {
      shard_name    = null
      config_server = true
      nodes         = [ for i in range (var.member_count) : merge(local.default_config_node, {
        name          = format("%s-config-%02d", var.name, i)
      })]
    }
  } : {}

  replica_sets = merge(local.data_replica_sets, local.config_replica_set)

  router_nodes = var.sharded && !var.cohost_routers ? [ for i in range (var.router_count) : merge(local.default_router_node, {
      name     = format("%s-router-%02d", var.name, i)
  })] : []

}
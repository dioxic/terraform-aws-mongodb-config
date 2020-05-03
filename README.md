# terraform-aws-mongodb-config

The [terraform-aws-mongodb](https://github.com/dioxic/terraform-aws-mongodb) module expects you to provide the configuration for the cluster setup like this:

```
data_replica_sets = [
  {
    "name" = "markbm-rs"
    "nodes" = [
      {
        "arbiterOnly" = false
        "hidden" = false
        "hostname" = "markbm-shard-00-00.example.com"
        "image_id" = "ami-06ce3edf0cff21f07"
        "instance_type" = "t2.micro"
        "is_router_node" = true
        "mongod_port" = 27017
        "name" = "markbm-shard-00-00"
        "priority" = 1
        "votes" = 1
      },
      ...
    ]
  },
]
```

It is verbose. Especially when you have a large cluster.

This module simplifies the config generation.

Pass in how many members you want, if the cluster is sharded, etc. and it will generate the config for you 
based on sensible defaults.

See the examples folder for...well...examples.
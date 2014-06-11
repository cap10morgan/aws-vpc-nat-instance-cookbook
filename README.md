aws-vpc-nat-instance Cookbook
=============================
This cookbook configures an Ubuntu EC2 instance to act as a VPC NAT gateway for your private subnet(s).

Requirements
------------
AWS credentials should be in an encrypted data bag named "aws_creds/[chef_environment]" and structured like this:

```json
{
  "id": "[chef_environment]",
  "access_key_id": "FOOBARBAZ",
  "secret_access_key": "quxquux"
}
```

Or I suppose you could use IAM roles, but I haven't tested this.

Attributes
----------
* `node['elastic_ip']` - You need to provision an elastic IP for your NAT instance and specify it in this attribute.

Optional:

* `node['route53']['zone_id']` - The Route 53 zone_id of the zone you'd like to add a DNS records to.
* `node['set_domain']` - The domain you'd like to add a route 53 DNS records in. Records will be [node_name].[set_domain] for the public IP and [node_name]-int.[set_domain] for the private IP.

Usage
-----
Just include `aws-vpc-nat-instance` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[aws-vpc-nat-instance]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Wes Morgan (cap10morgan) <cap10morgan@gmail.com>

License: Apache 2.0 (see LICENSE file)

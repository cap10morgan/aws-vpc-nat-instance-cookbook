name             'aws-vpc-nat-instance'
maintainer       'Wes Morgan'
maintainer_email 'cap10morgan@gmail.com'
license          'Apache 2.0'
description      'Configures EC2 instances to act as VPC NAT gateways for private subnets'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

recipe 'default', 'Configures EC2 instances to act as VPC NAT gateways for private subnets'

supports 'ubuntu'

depends 'iptables-ng', '~> 2.2.0'
depends 'node_dns', '~> 1.0.2'
depends 'sysctl', '~> 0.4.0'

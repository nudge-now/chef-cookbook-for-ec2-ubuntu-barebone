name             'barebone'
maintainer       'AD fresca Inc.'
maintainer_email 'dano@adfresca.com'
license          'All rights reserved'
description      'Installs/Configures barebone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# us-east1 ebs-backed AMI: ami-23d9a94a
# https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-23d9a94a

depends 'rbenv'
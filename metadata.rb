name 'nad-checks'
maintainer 'Wanelo, Inc'
maintainer_email 'james@wanelo.com'
license 'Apache 2.0'
description 'Additional checks for the Circonus node agent daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.2'

# http://github.com/modcloth-cookbooks/nad - upstream
# http://github.com/wanelo-chef/nad - wanelo fork, with updates
depends 'nad'

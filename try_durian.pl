use lib qw(./lib);
use common::sense;
use Durian::IOC qw(ioc_root);

my $root = ioc_root();
warn $root->fetch('Database/nic')->get;

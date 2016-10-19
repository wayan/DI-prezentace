use lib qw(./lib);
use common::sense;

$ENV{APP_ROOT} = '.';

use MyApp::Dummy;

my $dummy = MyApp::Dummy->new;
warn $dummy->username;

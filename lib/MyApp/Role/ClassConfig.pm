package MyApp::Role::ClassConfig;
use MooseX::Role::Parameterized;

use Types::Standard qw(ArrayRef Str);
use YAML qw(LoadFile);

parameter config_basename => ( is => 'ro', isa => Str, predicate => 'has_config_basename');

parameter attributes => ( is => 'ro', required => 1, isa => ArrayRef);

role {
    my $p = shift;

    my $config_path = sub {
        my $this = shift;

        # pokud neni jmeno parametrem, vytvorim ho ze tridy instance
        my $config_basename
            = $p->has_config_basename
            ? $p->config_basename
            : join( '-', split /::/, ref($this) ) . '.yml';
        return "$ENV{'APP_ROOT'}/etc/$config_basename";
    };

    has config => ( is => 'ro', lazy_build => 1 );

    method _build_config => sub {
        my $this        = shift;
        my $config_path = $this->$config_path;
        -f $config_path or die "Missing config file $config_path";
        return YAML::LoadFile($config_path);
    };

    for my $attr (@{$p->attributes}) {
        has $attr => (
            is      => 'ro',
            lazy    => 1,
            default => sub {
                my $this = shift;
                exists $this->config->{$attr}
                    or die sprintf "Missing parameter '%s' in config file '%s'", $attr, $this->$config_path;
                return $this->config->{$attr};
            }
        );
	after BUILD => sub { shift()->$attr };	
    }

    method BUILD => sub { };

};

1;


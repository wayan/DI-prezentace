package Durian::IOC;
use common::sense;

# ABSTRACT: the root of IOC tree

use Bread::Board::LazyLoader qw(load_container);
use Types::Standard qw(is_ArrayRef Str ArrayRef);
use Type::Params;

use Exporter 'import';
our @EXPORT_OK = qw(resolve ioc_root);

# search files in same directory
sub ioc_root {
    my ($root_dir) = __FILE__ =~ /(.*)\.pm/;

    return load_container(
        root_dir           => $root_dir,
        filename_extension => 'ioc'
    );
}

# resolves possibly more than one path at once
sub resolve {
    state $params = Type::Params::compile( Str | ArrayRef[ Str ] );

    my ( $path_arg ) = $params->(@_);

    my $root = ioc_root();
    my @resolved = map { $root->fetch($_)->get; } is_ArrayRef($path_arg) ? @$path_arg : $path_arg;
    return wantarray? @resolved: $resolved[0];
}

1;

# vim: expandtab:shiftwidth=4:tabstop=4:softtabstop=0:textwidth=78:

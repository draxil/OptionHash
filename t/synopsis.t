#!/usr/bin/perl

use strict;
use warnings;
use OptionHash;
use Test::Simple tests => 1;

use OptionHash;

my $cat_def = ohash_define( keys => [qw< tail nose claws teeth>]);

sub cat{
    my %options = @_;
    ohash_check( $cat_def, \%options);
    # ...
}

cat( teeth => 'sharp' );
eval{cat( trunk => 'long')}; # Boom, will fail. Cats dont expect to have a trunk.
ok($@);

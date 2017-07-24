package OptionHash;
# ABSTRACT: Checking of option hashes

=head1 SYNOPSIS

  use OptionHash;

  my $cat_def = ohash_define( keys => [qw< tail nose claws teeth>]);

  sub cat{
    my %options = @_;
    ohash_check( $cat_def, \%options);
    # ...
  }

  cat( teeth => 'sharp' );
  cat( trunk => 'long'); # Boom, will fail. Cats dont expect to have a trunk.

=head1 DESCRIPTION

I like to pass options around in hash form because it's clear and
flexible. However it can lead to sloppy mistakes when you typo the
keys. OptionHash quickly checks your hashes against a definition and croaks if
you've passed in bad keys.

Currently.. That's it! Simple but effective.

=head1 EXPORTED SUBS

=cut

use 5.0.4;
use strict;
use warnings;
use Carp;
use base qw< Exporter >;
our @EXPORT = (qw< ohash_check ohash_define >);
our $VERSION = '0.0.2';

my $ohash_def = bless {keys => {'keys' => 1}}, __PACKAGE__;


=head2 ohash_define

Define an optionhash specification, sort-of a type:

 my $cat_def = ohash_define( keys => [ qw< teeth claws > ]);

=cut
sub ohash_define{
    my %x = @_;
    ohash_check($ohash_def, \%x);
    my %def = ( keys => { map{ $_ => 1} @{$x{keys}}} );
    return bless \%def, __PACKAGE__;
}

=head2 ohash_check

Check a hash against a definition:

  ohash_check( $cat_def, \%options);

If everything is okay things will proceed, otherwise ohash_check will croak
(see Carp).

=cut

sub ohash_check($%){
    my($oh, $h) = @_;
    ref $oh eq 'OptionHash' or croak 'Not an OptionHash (you passed '.(ref $oh || 'a plain value').') - expecting ohash_check( $ohash_def, $hashref) ';
    ref $h eq 'HASH' or croak 'Not a hashref - expecting ohash_check( $ohash_def, $hashref) ';
    my $keys = $oh->{keys} or die;
    for( keys(%{$h}) ){
        if( ! exists $keys->{$_} ){
            croak "Invalid key $_ in OptionHash";
        }
    }
}

=head1 FUTURE

Maybe do the checking part with XS, although honestly it's fast in perl. Might
do an extra module as it's nice to have a pure perl version anyway.

Also other checks, like mandatory keys.

=cut

;1

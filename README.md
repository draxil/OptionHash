# OptionHash
Options hash checking for perl:
  
  ```use OptionHash;

  my $cat_def = ohash_define( keys => [qw< tail nose claws teeth>]);

  sub cat{
    my %options = @_;
    ohash_check( $cat_def, \%options);
    # ...
  }

  cat( teeth => 'sharp' );
  cat( trunk => 'long'); # Boom, will fail. Cats dont expect to have a trunk.
  ```

See [CPAN](https://metacpan.org/pod/OptionHash) for the full POD

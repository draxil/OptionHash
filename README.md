# OptionHash
Options hash checking for perl:
  
  ```use OptionHash;

  my $cat_def = ohash_define( keys => [qw< tail nose claws teeth >]);

  sub cat{
    my %options = @_;
    ohash_check( $cat_def, \%options);
    # ...
  }

  cat( teeth => 'sharp' );
  cat( trunk => 'long'); # Boom, will fail. Cats dont expect to have a trunk.
  ```
Generally the way to use this is to create the definition "types" at compile time in the package definition & then check against them later :

```
 package foo;
 use OptionHash;
 my $DOG_DEF = ohash_define( keys => [ qw< nose > ]);
 sub build_a_dog{
     my( %opts ) = @_;
     ohash_check($DOG_DEF, \%opts);
 }
 1;
 ```
See [CPAN](https://metacpan.org/pod/OptionHash) for the full POD

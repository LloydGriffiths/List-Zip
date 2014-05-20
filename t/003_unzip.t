use strict;
use warnings;

use List::Zip;
use Test::More;

my @sizes = (2, 5, 10, 50, 100, 500);

subtest 'unzips arrays of even size' => sub {
    for my $size (@sizes) {
        my @arrays;
        push @arrays, [ 1, 'one', 'a' ] for 1 .. $size;

        for my $unzipped (List::Zip->unzip(@arrays)) {
            is $unzipped->[0], $unzipped->[$_] for 1 .. $#{ $unzipped };
        }
    }
};

subtest 'unzips arrays of uneven size' => sub {
    for my $size (@sizes) {
        my @arrays;
        push @arrays, [ 0 .. (10 + rand 50) ] for 1 .. $size;

        my @unzipped = List::Zip->unzip(@arrays);

        for (1 .. $#unzipped) {
            is scalar @{ $unzipped[0] }, scalar @{ $unzipped[$_] };
        }
        for my $unzipped (@unzipped) {
            is $unzipped->[0], $unzipped->[$_] for 1 .. $#{ $unzipped };
        }
    }
};

done_testing;

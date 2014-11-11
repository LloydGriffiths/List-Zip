use strict;
use warnings;

use List::Zip;
use Test::More;

my @sizes = (2, 5, 10, 50, 100, 500);

subtest 'zips lists of even size' => sub {
    for my $size (@sizes) {
        # Zip lists that contain the same values so that we end up
        # with a simple test structure.
        #   [ 0 .. 10 ], [ 0 .. 10 ], [ 0 .. 10 ]
        #   [ 0, 0, 0 ], [ 1, 1, 1 ], [ 2, 2, 2 ] etc
        for my $zipped (List::Zip->zip(map { [ 0 .. 10 ] } 1 .. $size)) {
            is $zipped->[0], $zipped->[$_] for 1 .. $#{ $zipped };
        }
    }
};

subtest 'zips lists of uneven size' => sub {
    for my $size (@sizes) {
        # Create lists with different sizes. Minimum size set to
        # ten. These lists will be truncated to the same size and
        # should therefore be identical when zipped.
        my @zipped = List::Zip->zip(map { [ 0 .. (10 + rand 50) ] } 1 .. $size);

        for (1 .. $#zipped) {
            is scalar @{ $zipped[0] }, scalar @{ $zipped[$_] };
        }
        for my $zipped (@zipped) {
            is $zipped->[0], $zipped->[$_] for 1 .. $#{ $zipped };
        }
    }
};

subtest 'zips nested lists correctly' => sub {
    my @zipped1 = List::Zip->zip(map { [ 0 .. $sizes[0] ] } 0 .. $#sizes);
    my @zipped2 = List::Zip->zip(
        [ 0 .. $sizes[0] ], [ @zipped1 ]
    );

    # Create a list of the same structure as @zipped2 by creating a number
    # of lists equal to 0 .. $sizes[0]. Then generate a nested list with the size of
    # @sizes which only contains identical values which are the same as the value in
    # the outer list.
    is_deeply \@zipped2, [ map {
        [ $_, [ map { int $_ } split '', $_ x scalar @sizes ] ]
    } 0 .. $sizes[0] ];
};

done_testing;

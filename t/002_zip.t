use strict;
use warnings;

use List::Zip q(zip);
use Test::More;

subtest 'zips lists of even size' => sub {
    my @range   = 1 .. 5;
    my @expects = map { [ $_, $_ ] } @range;
    my @inputs  = ([ @range ], [ @range ]);
    my @actual  = zip(@inputs);

    is_deeply \@actual, \@expects;
};

subtest 'zips nested lists correctly' => sub {
    my @expects = ([ [ 1, 2 ], [ 3, 4 ] ], [ [ 5, 6 ], [ 7, 8 ] ]);
    my @inputs  = ([ [ 1, 2 ], [ 5, 6 ] ], [ [ 3, 4 ], [ 7, 8 ] ]);
    my @actual  = zip(@inputs);

    is_deeply \@actual, \@expects;
};

done_testing;

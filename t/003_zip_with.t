use strict;
use warnings;

use List::Zip q(zip_with);
use Test::More;

subtest 'zips lists of even size' => sub {
    subtest 'addition' => sub {
        my @range   = (1, 2, 4, 8);
        my @inputs  = (\@range, \@range);
        my @expects = map { $_ << 1 } @range;
        my @actual  = zip_with(@inputs => sub { $_[0] + $_[1] });

        is_deeply \@actual, \@expects;
    };

    subtest 'concatenation' => sub {
        my @inputs = (
            [ qw(q b h) ],
            [ qw(u r i) ],
            [ qw(i o p) ],
            [ qw(c w p) ],
            [ qw(k n o) ],
        );
        my @expects = qw(quick brown hippo);
        my @actual  = zip_with(@inputs => sub { join '', @_ });

        is_deeply \@actual, \@expects;
    };
};

subtest 'zips lists of uneven size' => sub {
    my @inputs  = ([ 1 .. 10 ], [ map { 1 } 1 .. 20 ]);
    my @expects = 1 .. 10;
    my @actual  = zip_with(@inputs => sub { $_[0] * $_[1] });

    is_deeply \@actual, \@expects;
};

done_testing;

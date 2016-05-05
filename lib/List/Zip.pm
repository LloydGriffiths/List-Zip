package List::Zip;

use strict;
use warnings;

use parent q(Exporter);

our $VERSION = '0.04';

our @EXPORT_OK = qw(
    zip
    zip_with
);

sub zip {
    return zip_with(@_, sub { \@_ });
}

sub zip_with {
    my ($f) = pop;

    return map { $f->(_map_elements(@_)) } 0 .. _cutoff(@_);
}

sub _cutoff {
    return (sort map { $#$_ } @_)[0];
}

sub _map_elements {
    return map { shift @$_ } @_;
}

1;

__END__

=pod

=head1 NAME

List::Zip - Module to zip lists.

=head1 DESCRIPTION

Provides functionality to zip lists. The provided subroutine returns a list formed
from the input lists.

L<List::MoreUtils> also provides functionality to C<mesh> lists. However, this
implementation differs. If the lists passed to C<zip> have different sizes all the
the lists will be truncated to the same size as the smallest list.

=head1 SYNOPSIS

    use List::Zip q(zip);

    my @zipped = zip(
        [ 1, 2, 3, 4, 5 ], [ 'one', 'two', 'three', 'four', 'five' ]
    );

    say $zipped[0]->[0]; # 1
    say $zipped[0]->[1]; # one
    say $zipped[1]->[0]; # 2
    say $zipped[1]->[1]; # two

    # We can get back to the original structure before zipping by zipping
    # the list again with no additional lists
    my @unzipped = zip(@zipped);

    say for @{ $unzipped[0] }; # 1 2 3 4 5
    say for @{ $unzipped[1] }; # one two three four five

=head1 FUNCTIONS

=head3 zip

Converts this list by combining corresponding elements from the input lists into
lists.

    my $zipped = zip([ 1 .. 5 ], [ 6 .. 10 ]);

The structure of the list returned by zipping the above is:

    [ 1, 6 ], [ 2, 7 ], [ 3, 8 ], [ 4, 9 ], [ 5, 10 ]

=head1 EXPORTS

None by default.

=head1 SEE ALSO

L<List::MoreUtils>

L<List::Gen>

=head1 AUTHOR

Lloyd Griffiths

=head1 COPYRIGHT

This software is copyright (c) 2014-2015 by Lloyd Griffiths.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.

=cut

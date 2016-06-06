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

    return map { $f->(_map_elements($_, @_)) } 0 .. _cutoff(@_);
}

sub _cutoff {
    return (sort { $a <=> $b } map { $#$_ } @_)[0];
}

sub _map_elements {
    my ($index) = shift;

    return map { $_->[$index] } @_;
}

1;

__END__

=pod

=head1 NAME

List::Zip - Module to zip lists.

=head1 DESCRIPTION

Provides functionality to zip list structures.

L<List::MoreUtils> also provides functionality to C<mesh> lists. However, this
implementation differs. If the lists provided have different sizes all of the
the lists will be truncated to the same size as the smallest list.

=head1 SYNOPSIS

    use List::Zip qw(zip zip_with);

    my @zipped      = zip([ 1, 2, 3, 4, 5 ], [ 'one', 'two', 'three', 'four', 'five' ]);
    my @unzipped    = zip(@zipped);
    my @zipped_with = zip_with([ 1, 2, 3 ], [ 4, 5, 6 ] => sub { return $_[0] + $_[1] });

=head1 FUNCTIONS

=head3 zip

Converts this list by combining corresponding elements from the input lists into
lists.

    my @zipped = zip([ 1 .. 5 ], [ 6 .. 10 ]);

The structure of the list returned by zipping the above is:

    ([ 1, 6 ], [ 2, 7 ], [ 3, 8 ], [ 4, 9 ], [ 5, 10 ])

=head3 zip_with

Converts this list by combining corresponding elements from the input lists into
lists. The given function is applied to each combination of the corresponding elements.

    my @zipped = zip_with([ qw(t f r f) ], [ qw(h a e o) ], [ qw(e t d x) ] => sub {
        return join '', @_;
    });

The structure of the list returned by zipping with the above function applied is:

    ('the', 'fat', 'red', 'fox')

=head1 EXPORTS

None by default.

=head1 SEE ALSO

L<List::MoreUtils>

L<List::Gen>

=head1 AUTHOR

Lloyd Griffiths

=head1 COPYRIGHT

This software is copyright (c) 2014-2016 by Lloyd Griffiths.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.

=cut

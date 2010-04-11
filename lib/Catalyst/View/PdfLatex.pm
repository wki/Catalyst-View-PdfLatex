package Catalyst::View::PdfLatex;

use Moose;
extends 'Catalyst::View';

has extension => (is => 'rw', default => '.tt');
has root_dir  => (is => 'rw', default => 'root/pdflatex');
has wrapper   => (is => 'rw', default => 'wrapper.tt');

=head1 NAME

Catalyst::View::PdfLatex

=head1 SYNOPSIS

=head1 METHODS

=head2 process

fulfill the request (called from Catalyst)

=cut

sub process {
    my $self = shift;
    my $c = shift;
    
    ### do this.
    
    return 1;
}

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

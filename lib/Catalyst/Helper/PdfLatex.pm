package Catalyst::Helper::View::PdfLatex;

use strict;

=head1 NAME

Catalyst::Helper::View::PdfLatex - Helper for PdfLatex Views

=head1 SYNOPSIS

    script/create.pl view PdfLatex PdfLatex

=head1 DESCRIPTION

Helper for PdfLatex Views.

=head2 METHODS

=head3 mk_compclass

=cut

sub mk_compclass {
    my ( $self, $helper ) = @_;
    my $file = $helper->{file};
    $helper->render_file( 'compclass', $file );
}

=head1 SEE ALSO

L<Catalyst::Manual>, L<Catalyst::Helper>

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;

__DATA__

__compclass__
package [% class %];

use Moose;
BEGIN { extends 'Catalyst::View::PdfLatex' }

__PACKAGE__->config(
    # # Change default
    # extension => '.tt',
    # 
    # # Set the location for .pl files
    # root_dir => 'root/pdflatex',
    # 
    # # This is your wrapper template located in the 'root_dir'
    # wrapper => 'wrapper.tt',
);

=head1 NAME

[% class %] - PdfLatex View for [% app %]

=head1 DESCRIPTION

PdfLatex View for [% app %]. 

=head1 METHODS
=cut



=head1 SEE ALSO

L<[% app %]>

=head1 AUTHOR

[% author %]

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

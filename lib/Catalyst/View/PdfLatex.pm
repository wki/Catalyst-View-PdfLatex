package Catalyst::View::PdfLatex;

use Moose;
extends 'Catalyst::View';

use Template;
use Catalyst::Utils;
use UUID::Random;
use Path::Class::File;
use File::Spec;
use MIME::Types;

has extension => (is => 'rw', default => '.tt');
has root_dir  => (is => 'rw', default => 'root/pdflatex');
has wrapper   => (is => 'rw', default => 'wrapper.tt');
has pdflatex  => (is => 'rw', default => '/opt/local/bin/pdflatex');

=head1 NAME

Catalyst::View::PdfLatex - generate PDF files via pdflatex

=head1 SYNOPSIS


=head1 DESCRIPTION

=head2 Stash Variables

=over

=item template

describes the template to render

=item wrapper

TODO: define a wrapper to use

=item filename

if it exists and is set the file id sent as an attachment. The result for the
user is that the download manager will file. Otherwise the PDF may be viewed
inline by the user's browser.

=back


=head1 METHODS

=head2 process

fulfill the request (called from Catalyst)

=cut

sub process {
    my $self = shift;
    my $c = shift;
    
    #
    # step 1: create LaTex Source Code from TT
    #
    my %tt_config = (
        INCLUDE_PATH => "${\$c->path_to($self->root_dir)}",
        INTERPOLATE => 1,
    );
    
    my $tempdir  = File::Spec->tmpdir;
    my $basename = UUID::Random::generate;
    
    my $tex_file = Path::Class::File->new($tempdir, "$basename.tex");
    my $pdf_file = Path::Class::File->new($tempdir, "$basename.pdf");
    
    my $template = Template->new(\%tt_config);
    $template->process($c->stash->{template}, 
                       { %{$c->stash()} },
                       "$tex_file",
                      )
        or die $template->error();
    
    #
    # step 2: create PDF from LaTeX
    #
    die "pdflatex binary not found at: ${\$self->pdflatex}"
        if (!$self->pdflatex || !-x $self->pdflatex);
    chdir($tempdir);
    my $dummy = `${\$self->pdflatex} -interaction=batchmode "$tex_file"`;
    die ".pdf file not present in $tempdir"
        if (!-f $pdf_file);
    
    #
    # step 3: distribute PDF
    #
    my $mime = MIME::Types->new->mimeTypeOf('pdf');
    if (exists($c->stash->{filename}) && $c->stash->{filename}) {
        $c->response->headers->header(
            'Content-Type'        => qq{$mime; name="${\$c->stash->{filename}}.pdf"},
            'Content-Disposition' => qq{attachment; filename="${\$c->stash->{filename}}.pdf"},
        );
    } else {
        # $c->response->headers->content_type($mime);
        $c->response->headers->header(
            'Content-Type' => $mime,
        );
    }
    $c->response->body( '' . $pdf_file->slurp() ); # GOTCHA: scalar context!!
    
    #
    # step 4: remove all files we generated right now...
    #
    # foreach my $file ($tex_file->dir->children) {
    #     next if (substr($file->basename, 0, length($basename)) ne $basename);
    #     $c->log->debug("removing file: $file");
    #     $file->remove();
    # }
    
    # warn 'process is done now.';
    return 1;
}

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

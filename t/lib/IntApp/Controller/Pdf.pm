package IntApp::Controller::Pdf;
use Moose;
BEGIN { extends 'Catalyst::Controller' }

sub getit :Local {
    my ($self, $c) = @_;
    
    $c->stash->{template} = 'simple.tt';
    delete $c->stash->{filename};
    $c->forward('View::PdfLatex');
}

sub loadit :Local {
    my ($self, $c) = @_;
    
    $c->stash->{template} = 'simple.tt';
    $c->stash->{filename} = 'a_simple_filename';
    $c->forward('View::PdfLatex');
}

1;

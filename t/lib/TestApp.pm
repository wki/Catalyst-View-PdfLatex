package TestApp;

use Moose;
extends 'Catalyst';

use Catalyst::Runtime '5.80';
use FindBin;

use Catalyst ( qw(-Log=error) );

__PACKAGE__->config(
        name => 'TestApp',
        home => "$FindBin::Bin",
        'View::PdfLatex' => {
            extension => '.xxtt',
            root_dir  => 'xxroot/xxpdflatex',
            wrapper   => 'xxx.tt',
        },
);

__PACKAGE__->setup();

1;

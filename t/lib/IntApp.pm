package IntApp;

use Moose;
extends 'Catalyst';

use Catalyst::Runtime '5.80';
use FindBin;

use Catalyst ( qw(-Log=error) );

__PACKAGE__->config(
        name => 'IntApp',
        home => "$FindBin::Bin",
        'View::PdfLatex' => {
        },
);

__PACKAGE__->setup();

1;

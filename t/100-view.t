use Test::More;
use Test::Exception;
use Catalyst ();
use FindBin;
use lib "$FindBin::Bin/lib";
use Path::Class;

# setup our Catalyst :-)
my $c = Catalyst->new();
$c->setup_log();
$c->setup_home("$FindBin::Bin");

# can we use it?
use_ok 'Catalyst::View::PdfLatex';

# check for methods
can_ok('Catalyst::View::PdfLatex' => qw(extension root_dir wrapper));

# instantiate
my $view;
lives_ok { $view = $c->setup_component('Catalyst::View::PdfLatex') } 'setup view worked';
isa_ok($view, 'Catalyst::View::PdfLatex', 'view class looks good');

### test only ::: is($view->_application->path_to('root'), 'adsf', 'bla');
# check default attributes
is($view->extension, '.tt', 'extension looks good');
is($view->root_dir,  'root/pdflatex', 'root_dir looks good');
is($view->wrapper,   'wrapper.tt', 'wrapper looks good');


done_testing();

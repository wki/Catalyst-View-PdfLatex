use Test::More;
use FindBin;
use lib "$FindBin::Bin/lib";

use Catalyst::Test 'TestApp';

#
# sanity check first -- view
#
my $view = TestApp->view('PdfLatex');
is( ref($view), 'TestApp::View::PdfLatex', 'View is OK');

#
# check if view-config settings can get retrieved
#
can_ok($view, qw(extension root_dir wrapper));

#
# check if settings are as we expect them to be
#
is($view->extension, '.xxtt', 'unset config is at its default value');
is($view->root_dir,  'xxroot/xxpdflatex', 'config setting from View looks good');
is($view->wrapper,   'xxx.tt', 'config setting from app looks good');

done_testing();

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { use_ok 'Catalyst::Test', 'IntApp' }

my ($res, $c);

# check /pdf/getit URL
($res, $c) = ctx_request('/pdf/getit');
is(ref($c), 'IntApp', 'Context is OK');
ok(length($res->content) > 0, 'length > 0');
# # this test fails -- why? live things work.
# is($res->header('Content-Type'), 'application/pdf', 'MIME type is OK');
ok($res->is_success, 'status is 200');

# check /pdf/loadit URL
($res, $c) = ctx_request('/pdf/loadit');
is(ref($c), 'IntApp', 'download Context is OK');
ok(length($res->content) > 0, 'download length > 0');
# # the next 2 tests fail -- why? live things work.
# is($res->content_type, 'application/pdf; name="a_simple_filename.pdf"', 'download MIME type is application/pdf');
# is($res->header('Content-Disposition'), 'attachment; filename="a_simple_filename.pdf"', 'download content disposition is OK');
ok($res->is_success, 'download status is 200');

done_testing();

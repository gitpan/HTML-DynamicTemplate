#
#   test of recursion and infinite recursion errors
#

use strict;
use HTML::DynamicTemplate;


#   this should be fatal /---------------------------------
#
print "1..1\n";
eval {
    local *STDERR;
    open( STDERR, "> t/recursion_error_message.txt") || die $!;

    my $template = new HTML::DynamicTemplate ('t/templates/infinite.tmpl');
    $template->set_recursion_limit( 15 );
    my $result = $template->render();
};
die "include recursion test failed"
    unless (-f "t/recursion_error_message.txt");
print "ok 1\n";




#   check recursion between variables /--------------------
#
print "1..2\n";
my $result;
eval {
    local *STDERR;
    open( STDERR, "> t/error_message.txt") || die $!;

    my $template = new HTML::DynamicTemplate ('t/templates/errors.tmpl');
    $result = $template->render();
};



local $/ = undef;
open EXPECTED, "< t/errors_expected.txt" || die $!;
my $expected .= <EXPECTED>;
close EXPECTED;

open RESULT, "> t/errors_result.txt" || die $!;
print RESULT $result;
close RESULT;

print "not " unless $result eq $expected;

print "ok 2\n";

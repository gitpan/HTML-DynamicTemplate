use strict;
use HTML::DynamicTemplate;

print "1..1\n";

my $template = new HTML::DynamicTemplate('t/templates/test.tmpl');
$template->set_recursion_limit(5);

$template->set(TEST => 'TEST');
$template->set(TEST_ALPHA => 'ALPHA',
               TEST_BETA  => 'BETA',
               TEST_GAMMA => 'GAMMA',
               SET => 'SET',
               INCLUDE => 'INCLUDE',
               INCLUDE_PATH => 'T/TEMPLATES/INCLUDE.TMPL');

$template->clear;

#   regular stuff
#
$template->set(TEST => 'Test');
$template->set(
    TEST_ALPHA => 'Alpha',
    TEST_BETA  => 'Beta',
    TEST_GAMMA => 'Gamma',
    SET => 'Set',
    INCLUDE => 'Include',
    INCLUDE_PATH => 't/templates/include.tmpl'
);

#   callbacks
#
$template->set('TITLE' =>
    sub{
        my $this = shift;
        $this->clear('TITLE');
        return 'test'
    }
);

my $result = $template->render();
my $expected;

local $/ = undef;
open EXPECTED, "t/nominal_expected.txt" || die $!;
$expected .= <EXPECTED>;
close EXPECTED;

open RESULT, ">t/nominal_result.txt" || die $!;
print RESULT $result;
close RESULT;

print "not " unless $result eq $expected;

print "ok 1\n";

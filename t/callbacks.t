#
#   test of setting template variable callbacks
#

use strict;
use HTML::DynamicTemplate;

print "1..1\n";


my $template = new HTML::DynamicTemplate ('t/templates/callbacks.tmpl');

$template->set(
    'CALLBACK1' => sub{
        my $this = shift;
        $this->set('AUTHOR' => 'matt harrison');
        return 'successful';
    }
);

$template->set(
    'CALLBACK2' => sub{
        my( $this, $name ) = @_;
        $this->clear('CALLBACK1');
        return 'successful';
    }
);

my $result = $template->render();

local $/ = undef;
open EXPECTED, "t/callbacks_expected.txt" || die $!;
my $expected .= <EXPECTED>;
close EXPECTED;

open RESULT, ">t/callbacks_result.txt" || die $!;
print RESULT $result;
close RESULT;

print "not " unless $result eq $expected;

print "ok 1\n";

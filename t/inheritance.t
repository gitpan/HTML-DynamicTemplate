#
#   test of inheriting from base class
#

use strict;
use HTML::DynamicTemplate;

print "1..1\n";

BEGIN
{
    package TestTemplate;
    @TestTemplate::ISA = 'HTML::DynamicTemplate';

    sub callback_ARRAY
    {
        my( $this, $name, $data ) = @_;
        my $list = "<ul>\n";

        foreach my $item ( @$data )
        {
            $list .= "<li>$item\n";
        }
        $list .= "</ul>";

        return $list;
    }
}

my @items = qw/ alpha beta gamma delta epsilon /;

my $template = new TestTemplate ('t/templates/inheritance.tmpl');
$template->set('LIST' => \@items );
my $result = $template->render();

local $/ = undef;
open EXPECTED, "t/inheritance_expected.txt" || die $!;
my $expected .= <EXPECTED>;
close EXPECTED;

open RESULT, ">t/inheritance_result.txt" || die $!;
print RESULT $result;
close RESULT;

print "not " unless $result eq $expected;

print "ok 1\n";

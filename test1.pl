#!/usr/bin/perl -w -I.
#
# test list obj.

use strict;
use warnings;

use Article;
use List;

my $list_obj_1 = List->new( storage_path => "foo.dat" );

my $list_obj_2 = List->new();


# load stored entries
# (done automatically in constr.)
#$list_obj_1->load();

print "loaded entry corr.: ";
($list_obj_1->{'list'}[1]{'data'}{'company'} eq "FOOCOMP & Co.") ?
    print "PASS\n" : print "FAILED\n";

print "list entry corr.: ";
($list_obj_1->{'list'}[0]{'data'}{'name'} eq "Keyboard ABC 5") ?
    print "PASS\n" : print "FAILED\n";

# store list to file

$list_obj_1->store();

# check stored file (line 1)
print "stored line 1 corr.: ";
open(my $fh_0, "<" . $list_obj_1->{'storage_path'}) or die "cannot open file :(...";
my $line1 = readline($fh_0);
# debug
#print $line1;
($line1 eq "10\tMYCOMP.org\tKeyboard ABC 5\tStk\t\n") ?
    print "PASS\n" : print "FAILED\n";


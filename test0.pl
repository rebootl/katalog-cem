#!/usr/bin/perl -w -I.
#
# tests article obj.

use strict;
use warnings;

use Article;

my $article_1 = Article->new( {
    name => "maus USB",
    company => "Logitech",
    amount => 5,
} );

print "article val corr.: ";
($article_1->{'data'}{'company'} eq "Logitech") ?
    print "PASS\n" : print "FAILED\n";

print "article def corr.: ";
print $article_1->{'data'}{'unit'} . "\n";

print "label hash corr.: ";
# debug
#print Article::get_label()->{'name'} . "\n";
#my $label_ref = Article::get_label();
#print %{$label_ref}{'name'} . "\n";
#print ${%label}{'name'};
print $Article::label{'name'} . "\n";
#($Article::label{'amount'} eq "Menge") ?
#    print "PASS\n" : print "FAILED\n";

print "article uid def.: ";
(defined $article_1->{'uid'}) ?
    print "PASS\n" : print "FAILED\n";

print "article uid corr.: ";
($article_1->{'uid'} eq "maus-USB_Logitech") ?
    print "PASS\n" : print "FAILED\n";

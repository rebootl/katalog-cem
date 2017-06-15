#!/usr/bin/perl -w -I.
#
# tests article obj.

use strict;
use warnings;

use Article;

my $article_1 = Article->new(
    name => "maus USB",
    company => "Logitech",
    amount => 5,
);

print "article val corr.: ";
($article_1->{'data'}{'company'} eq "Logitech") ?
    print "PASS\n" : print "FAILED\n";

print "article def corr.: ";
($article_1->{'data'}{'unit'} eq "Stk") ?
    print "PASS\n" : print "FAILED\n";

print "label hash corr.: ";
($Article::label{'name'} eq "Bezeichnung") ?
    print "PASS\n" : print "FAILED\n";

print "article uid def.: ";
(defined $article_1->{'uid'}) ?
    print "PASS\n" : print "FAILED\n";

print "article uid corr.: ";
($article_1->{'uid'} eq "maus-USB_Logitech") ?
    print "PASS\n" : print "FAILED\n";


### debug
#print "----------------------\n";
#
#my %data = (
#    name => 'testartikel 123',
#    company => 'example AG',
#    amount => 1,
#    unit => 'Stk',
#);
#my @args = (
#    'name', 'fooBUBU',
#    'company', 'LULU & Co.'
#);
#
#my %data = 
#%data = (%data, @args);
#
#foreach my $key (keys %data) {
#    print $key . " = " . $data{$key} . "\n";
#}

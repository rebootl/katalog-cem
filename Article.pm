# Article.pm
#
# article object
#
#

use strict;
use warnings;

package Article;

use Helper qw(escape_str_uid);

our @keys = (
    'name',
    'company',
    'amount',
    'unit',
);
# here we could use 'my ...' and a getter alternatively:
# my @keys = ( ... )
# sub get_keys() { return @keys; }

our @labels = (
    'Bezeichnung',
    'Firma',
    'Menge',
    'Einheit',
);

our %label;
@label{@keys} = @labels;
# this creates a hash in the form of:
# (
#   name => 'Bezeichnung',
#   company => 'Firma',
#   ..
# )
#
# ref:
# - https://stackoverflow.com/questions/3715957/how-can-i-assign-two-arrays-to-a-hash-in-perl

my @defaults = (
    'testartikel 123',
    'example AG',
    1,
    'Stk',
);

# (constructor)
sub new {
    my $class = shift;

    my %data_vals;
    @data_vals{@keys} = @defaults;

    #%data_vals = @_;

    my $this = {
        data => \%data_vals,
#        data => {
#            name => 'testartikel 123',
#            company => 'example AG',
#            amount => 1,
#            unit => 'Stk',
#        },
    };

    $this->{'data'} = @_;

    bless($this, $class);

    $this->make_uid();

    return $this;
}

sub make_uid() {
    #my $this = $_[0];
    my $this = shift;

    $this->{'uid'} = Helper::escape_str_uid($this->{'data'}{'name'} .
        "_" . $this->{'data'}{'company'});
}

1;

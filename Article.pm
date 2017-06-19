# Article.pm
#
# article object
#
#

use strict;
use warnings;

package Article;

use Helper qw(escape_str_uid);

my @keys = (
    'name',
    'company',
    'amount',
    'unit',
);

my @label_values = (
    'Bezeichnung',
    'Firma',
    'Menge',
    'Einheit',
);

my @default_values = (
    'testartikel 123',
    'example AG',
    1,
    'Stk',
);

# create hashes for labels and defaults
# this creates a hash in the form of:
#
# (
#   name => 'Bezeichnung',
#   company => 'Firma',
#   ..
# )
#
# ref:
# - https://stackoverflow.com/questions/3715957/how-can-i-assign-two-arrays-to-a-hash-in-perl
my %labels;
@labels{@keys} = @label_values;
my %defaults;
@defaults{@keys} = @default_values;

# (getters)
sub get_keys() { return \@keys; }
sub get_labels() { return \%labels; }
sub get_label() {
    # (achtung arg. ist $_[1])
    my $key = $_[1];
    return $labels{$key};
}

# (constructor)
sub new {
    my $class = shift;

    # overwrite default values by arguments
    my %data_vals = (%defaults, @_);

    # debug
    #foreach my $v (@{_}) {
    #    print ${v} . "\n";
    #}
    #foreach my $key (keys %data_vals) {
    #    print $key . " = " . $data_vals{$key} . "\n";
    #}

    my $this = {
        data => \%data_vals,
#        data => {
#            name => 'testartikel 123',
#            company => 'example AG',
#            amount => 1,
#            unit => 'Stk',
#        },
    };

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

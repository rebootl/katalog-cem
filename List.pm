# List.pm
#
# list object
#
#

use strict;
use warnings;

package List;

# (==> incl. external)
use Article;

# (from tutorial 7.3)
# ("constructor")
#
# Create a new class instance (object)
# and return a reference of the object
#
# also see ref: - https://docstore.mik.ua/orelly/perl3/prog/ch12_04.htm
sub new {
    #my $arg0 = shift;
    #my $class = ref($arg0) || $arg0;
    # ==> simplified
    # --> why is this done ?
    my $class = shift;

    my $this = {
        storage_path => "list.dat", # (use a default attribute)
        entry_type => "Article",
        @_,                         # Override previous attributes (see ref.)
    };

    bless($this, $class);

    $this->{'entry_type'}->can('new') or die "Noooo... :(\n";

    $this->{'list'} = [];
    $this->load();

    return $this;
}

# (from tutorial 7.3)
#sub clear {
#    my $this = $_[0];
#}
#sub clear {}

# evtl. getter for the list
#sub getList {
#}

# add an entry to the list
sub addEntry {}

# modify an existing entry
sub editEntry {}

# delete entry
sub deleteEntry {}

# store the list on filesystem
sub store {
    my $this = shift;

    my $str_list = "";
    foreach my $entry (@{$this->{'list'}}) {

        my $line = "";
        foreach my $key (sort keys %{$entry->{'data'}}) {
            $line .= %{$entry->{'data'}}{$key} . "\t";
        }
        $str_list .= $line . "\n";
    }

    my $filehandle_F;
    open($filehandle_F, ">" . $this->{'storage_path'}) or die;
    print $filehandle_F $str_list;
}

# load the list from filesystem
sub load() {
    my $this = shift;

    return 1 if (! -f $this->{'storage_path'});

    open(my $fh_0, "<" . $this->{'storage_path'}) or die "bad... :(";

    while (my $line = readline($fh_0)) {

        # get values
        my @values = split /\t/, $line;
        # debug
        #foreach my $v (@values) { print $v . "|"; }

        # create new default obj inst. of given type
        my $obj_inst = $this->{'entry_type'}->new();

        my $i = 0;
        foreach my $key (sort keys %{$obj_inst->{'data'}}) {
            $obj_inst->{'data'}{$key} = $values[$i];
            # debug
            #print $key . " => " . $values[$i] . "\n";
            $i += 1;
        }

        push(@{$this->{'list'}}, $obj_inst);

        # debug
        #foreach my $key (sort keys %{$obj_inst}) {
        #    print $key . " = " . ${$obj_inst}{$key} . "\n";
        #}

        # debug
        #print $line;
    }



}

# get some pseudo list data cause too lazy
# to write fs function now
sub load_pseudo {
    my $this = $_[0];

    # some pseudo data
    my $art_1 = Article->new(
        'name' => "Keyboard ABC 5",
        'amount' => 10,
        'company' => "MYCOMP.org",
        'unit' => "Stk"
    );
    my $art_2 = Article->new(
        'name' => "BUBUArt",
        'amount' => 5,
        'company' => "FOOCOMP & Co.",
        'unit' => "M"
    );
    my $art_3 = Article->new(
        'name' => "tutUArt",
        'amount' => 20,
        'company' => "FOOCOMP & Co.",
    );

    push(@{$this->{'list'}}, $art_1);
    push(@{$this->{'list'}}, $art_2);
    push(@{$this->{'list'}}, $art_3);
}

1;

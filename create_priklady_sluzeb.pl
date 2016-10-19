use common::sense;
use List::Util qw(min);

my $rows_per_slide = shift;

my @rows = <>;
my $title = "Příklady služeb";
my $i = 1;
for(my $from = 0; $from < @rows; $from+=$rows_per_slide){
    $i++ ;
    my $to = min($from + $rows_per_slide, @rows - 1);
    my $the_rows = join '', @rows[ $from .. $to ];

print <<"END_TXT";	
    <section class="slide">
        <h2>$title</h2>

        <pre>$the_rows</pre>
    </section>
END_TXT

    $rows_per_slide = int($rows_per_slide * 1.3);
    $title = "Příklady služeb díl $i.";
}

# vim: expandtab:shiftwidth=4:tabstop=4:softtabstop=0

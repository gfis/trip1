#!perl

# Convert Gauß-Krüger data to (decimal) geo positions
# @(#) $Id$
# 2021-06-10, Georg Fischer
# Previously:
# git clone https://github.com/okin/GKtoLatLong
# and install it into Perl
#------------------------

use strict;
use warnings;
use GKtoLatLong; # from 

while (<>) {
    next if $_ !~ m{\A\d};
    s/\s+\Z//;
    my ($tk, $tpnr, $ord, $rechts, $hoch, $ort, $name) = split(/\t/);
    $rechts =~ s{\,}{\.};
    $hoch   =~ s{\,}{\.};
    &convGKtoLatLong($rechts, $hoch);
    print join("\t", $tk, $tpnr, $ord, sprintf("%-9.6fN\t%-8.6fE", $rechts, $hoch), $ort, $name) . "\n";
} # while
__DATA__
TK	Hauptpunktnr	Ordn.	Rechtswert	Hochwert	Gemarkung	TP-Name
6323	00100	01	3538060,02	5501724,30	Külsheim	Taubenloch
6422	00100	01	3528050,29	5489502,32	Hettingen	Rehberg
6424	00200	01	3555043,78	5493382,80	Messelhausen	Streitberg
6516	00100	01	3460923,58	5483434,85	Mannheim	Sternwarte

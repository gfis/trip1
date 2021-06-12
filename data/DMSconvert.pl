#!perl

# Convert Degree Minutes Seconds to (decimal) geo positions
# @(#) $Id$
# 2021-06-11, Georg Fischer

use strict;
use warnings;
# use GKtoLatLong;

while (<DATA>) {
	next if $_ !~ m{\A\d};
	s/\s+\Z//;
	my ($dlat, $mlat, $slat, $dlon, $mlon, $slon) = m{([\d\,\.]+)}g;
	$slat =~ s{\,}{\.};
	$slon =~ s{\,}{\.};
	my $lat  = $dlat + $mlat/60 + $slat/3600;
	my $lon  = $dlon + $mlon/60 + $slon/3600;
	print sprintf("%-9.6fN\t%-8.6fE", $lat, $lon) . "\n";
} # while
__DATA__
48° 42' 34,96"  8°24'56,27"
48° 42' 35   "  8°24'56.3 "
Ergebnis: 48.709711N      8.415631E

Lat:      48.709854°(N)   8.415645° (E) mit https://www.koordinaten-umrechner.de/decimal/48.709854,8.415645?karte=OpenStreetMap&zoom=17
GKconvert 48.709865N      8.415654E
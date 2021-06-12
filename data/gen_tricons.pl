#!/usr/bin/perl

# Generate SVG icons for trip1
# @(#) $Id$
# 2021-06-11, Georg Fischer: copied from ocm/gen_icons.pl
#
# Usage:
#   perl gen_tricons.pl
# (Over-)writes a series of SVG images in subdirectory trip1/web/icons
#------------------------------------------------------------------
use strict;

    my $out_dir = "../web/icons";
    my $tar_dir = "/var/www/html/punctum/project/ocm/icons";
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
    my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
    my $key;
    my $value;
    while (scalar(@ARGV) > 0) {
        my $opt = shift(@ARGV);
        if ($opt !~ m{\A\-}) { # no hyphen - output directory
            $out_dir = $opt;
        } elsif ($opt eq "-k") {
            $key = shift(@ARGV);
        } elsif ($opt eq "-v") {
            $value = shift(@ARGV);
        } else {
            print STDERR "invalid option \"$opt\"\n";
        }
    } # while ARGV
    #-------------
    my $base_path       = "M12,32 l0,28 40,0 0,-20 "; # shape of the base of the building, like "|_|"
    my $roof_path; # the shape at the top of the building
    my $church_roof     = "-8,-8 -16,0 0,-12 -8,-12 -8,12 0,12"; # tower left for a christian church    |^|_
    my $chapel_roof     = "-8,-8 -16,0       -8,-8  -8,8"      ; # little helmet for a christian chapel ^__
    my $jewish_roof     = "0,-8 -20,-12 -20,12"           ; # triangular shape /\
    my $muslim_roof     = "0,-26 -4,-4 -4,4 0,18 q -14,-16 -32,0 " ; # dome shape ( and minarett ||

    my $sign_path;      # path for the sign inside the building, empty if not present
    my $cross_sign      = "M30,36 l0,6 -6,0 0,4 6,0 0,10 4,0 0,-10 6,0 0,-4 -6,0 0,-6 z"; # starts at left upper corner
    my $jewish_sign     = "M32,28 l-12,21 24,0z m-12,7 l12,21 12,-21z"; 
    my $muslim_sign     = "M30,32 a 11,11 0 1 0 12,12 a 9,9 0 1 1 -12,-12";
    my $shape_fill;     # fill color    for the building
    my $shape_width = 2;# width of the  shape stroke
    my $shape_stroke;   # stroke color  for the building
    my $sign_fill;      # fill color    for the sign
    my $sign_stroke;    # stroke color  for the sign
    my $sign_width = 1; # width of the  sign stroke

    $sign_path          = $cross_sign;
    $shape_stroke       = "red";
    $sign_fill          = "white";
    $sign_stroke        = "red";
    $sign_width         = 0;
    
    my $ev_color        = "#8A2BE2"; # "blueviolet";
    $shape_fill         = $ev_color;
    $roof_path          = $church_roof;
    &gen1("church-ev");
    $roof_path          = $chapel_roof;
    &gen1("chapel-ev");

    my $rk_color        = "yellow";
    $shape_fill         = $rk_color;
    $sign_fill          = "red";
    $roof_path          = $church_roof;
    &gen1("church-rk");
    $roof_path          = $chapel_roof;
    &gen1("chapel-rk");

    $shape_fill         = "url(#mixedUsage)";
    $sign_fill          = "red";
    $roof_path          = $church_roof;
    &gen1("church-ek");
    $roof_path          = $chapel_roof;
    &gen1("chapel-ek");

    $shape_fill         = "darksalmon"; # "#DCDCDC"; # "gainsboro", a light gray;
    $sign_fill          = "white";
    $roof_path          = $church_roof;
    &gen1("church-xx");
    $roof_path          = $chapel_roof;
    &gen1("chapel-xx");
    
    $shape_stroke       = "lightgray";
    $sign_path          = $jewish_sign;
    $sign_fill          = "blue";
    $sign_stroke        = "white";
    $sign_width         = "2";
    $shape_fill         = "blue";
    $roof_path          = $jewish_roof;
    &gen1("jewish");

    $sign_path          = $muslim_sign;
    $sign_fill          = "white";
    $sign_stroke        = "white";
    $sign_width         = "0";
    $shape_fill         = "green";
    $roof_path          = $muslim_roof;
    &gen1("muslim");

#-------------------------------------
sub gen1 { # generate 1 icon file
    my ($out_name) = @_;
    my $out_file = "$out_dir/$out_name.svg";
    open(OUT, ">", $out_file) || die "cannot write \"$out_file\"";
    print STDERR "writing $out_file\n";
    print OUT <<"GFis"; # SVG header
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created by gfis/trip1/data/gen_tricons.pl at $timestamp -->
<svg id="s0" version="1.1" 
    xmlns="http://www.w3.org/2000/svg" 
    height="64" width="64"
    >
GFis
    print OUT <<"GFis"; # outline shape
    <g id="g1" fill="$shape_fill" stroke-width="$shape_width" stroke="$shape_stroke" >
        <path id="p2" d="$base_path $roof_path Z" />
    </g>
GFis
    if (length($sign_path) > 0) { # with sign inside
    print OUT <<"GFis"; # center sign, if any
    <g id="g3" fill="$sign_fill"  stroke-width="$sign_width"  stroke="$sign_stroke" >
        <path id="p4" d="$sign_path" />
    </g>
GFis
    } # with sign
    print OUT <<"GFis"; # SVG trailer
</svg>
GFis
    close(out);
    my $tar_file = "$tar_dir/$out_name.png";
    print `convert -background transparent $out_file $tar_file`;
} # gen1
__DATA__
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with gfis/trip1/data/gen_tricons.pl -->
<svg id="svg4858" version="1.1" 
    xmlns="http://www.w3.org/2000/svg" 
    height="64" width="64"
    >
<g id="layer1" >
    <g id="g1" fill="yellow" stroke-width="2" stroke="red" >
        <path id="p2" d="M12,32 l0,28 40,0 0,-28 0,-12 -8,-12 -8,12 0,12 Z" />
    </g>
    <g id="g3" fill="white"  stroke-width="1"  stroke="blue" >
        <path id="p4" d="M30,36 l0,6 -6,0 0,4 6,0 0,10 4,0 0,-10 6,0 0,-4 -6,0 0,-6 Z" />
    </g>
</g>
</svg>

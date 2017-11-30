#!/usr/bin/env perl
#
# weather.pl --- Get and display weather.
#
# Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    24 Mar 2017 01:16:27
#
#{{{ License:
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.
#
#}}}
#{{{ Commentary:
#
#}}}

use strict;
use warnings;
use JSON::Parse 'parse_json';
use WWW::Curl::Easy;
use Storable qw(lock_store lock_retrieve);
use Data::Dumper;

my $freegeoip         = "http://freegeoip.net/json/";
my $openweathermapkey = undef;
my $response          = undef;
my $retcode           = undef;
my $curl              = WWW::Curl::Easy->new;

unless (defined $openweathermapkey) {
    die "You need to obtain and set up an OpenWeatherMap API key.";
}

sub store_init {
    my $store = shift;

    unless (-f $store) {
        store_write_scalar(0, $store);
    }
}

sub store_write_scalar {
    my $what  = shift;
    my $store = shift;
    my %map   = (value => $what);

    lock_store(\%map, $store)
        or die("Could not write store: $!");
}

sub store_read_scalar {
    my $store = shift;

    my $mapref = lock_retrieve($store)
        or die("Could not get store: $!");

    return $mapref->{value};
}

$curl->setopt(CURLOPT_URL, $freegeoip);
$curl->setopt(CURLOPT_WRITEDATA, \$response);

$retcode = $curl->perform;
if ($retcode == 0) {
    my $data = parse_json($response);

    print $data->{city} . ", " . $data->{country_name} . "\n";
} else {
    
}

# weather.pl ends here.
#
# Local Variables: ***
# mode:cperl ***
# End: ***

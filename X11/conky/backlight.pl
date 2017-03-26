#!/usr/bin/env perl
#
# backlight.pl --- Backlight
#
# Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    10 Mar 2017 07:47:36
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
use POSIX;

sub trim {
    my $str = shift;

    $str =~ s/^\s+//;
    $str =~ s/\s+$//;

    return $str;
}

my $max = trim(`cat /sys/class/backlight/intel_backlight/max_brightness`);
my $cur = trim(`cat /sys/class/backlight/intel_backlight/brightness`);

print (($cur / $max) * 100);
print "\n"

# backlight.pl ends here.
#
# Local Variables: ***
# mode:cperl ***
# End: ***

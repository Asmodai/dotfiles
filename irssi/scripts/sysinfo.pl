#!/usr/bin/env perl
#
# sysinfo.pl --- System information.
#
# Copyright (c) 2023 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    13 Jul 2023 14:26:47
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
use Irssi 20011210.0250 ();
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = {
  authors     => 'Paul Ward',
  contact     => 'asmodai@gmail.com',
  name        => 'sysinfo',
  description => 'Adds a /sysinfo command which prints system information (linux only).',
  license     => 'GNU GPLv2 or later',
  url         => '',
};

use vars qw/$colour $graphs $graphs2 $colour2 $style/;
Irssi::command_bind("sysinfo","sysinfo");

sub parseopts{
  my($netinfo,@options) = @_;

  my $tmp = shift(@options) if $options[0] =~ /^\-/;
  $tmp =~ s/^\-//;

  for (split //,$tmp) {
    if ($_ eq "c") {
      $tmp =~ /c(\d+)/;
      $colour = $1;

      if (!$colour) {
        $colour = 3;
      }
    } elsif ($_ eq "g") {
      $tmp =~ /g(\d+)/;
      $graphs = $1;

      if (!$graphs) {
        $graphs = 9;
      }
    } elsif ($_ eq "G") {
      $tmp =~ /G(\d+)/;
      $graphs2 = $1;
    } elsif ($_ eq "C") {
      $tmp =~ /C(\d+)/;
      $colour2 = $1;
    }
  }

  if (!defined $colour2 && $colour) {
    $colour2 = 15;
  }

  if (defined $graphs && !defined $graphs2) {
    $graphs2 = 3;
  }

  # We got the names on the command line
  if ($options[1]) {
    $style = join(" ",@options);
    # style name
  } elsif ($options[0]) {
    if ($options[0] eq "std") {
      $style = "os up cpu mem";
      $style .= " video" if (defined $ENV{DISPLAY});
    } elsif ($options[0] eq "bigger") {
      $style = "os up cpu cache mem load procs disk";
      $style .= " video" if (defined $ENV{DISPLAY});
    } elsif ($options[0] eq "full") {
      $style = "host os up cpu cache mem users load procs swap disk ethernet ".join(" ", keys %{$netinfo});
      $style .= " video" if (defined $ENV{DISPLAY});
    } elsif ($options[0] eq "net") {
      $style = join(" ",keys %{$netinfo});
    } elsif ($options[0] eq "uptime") {
      $style = "os up";
    } elsif ($options[0] eq "use") {
      $style = "mem swap disk";
    }
  } else {
    # no input - default
    $style = "os up cpu swap mem procs disk";
    $style .= " video" if (defined $ENV{DISPLAY});
  }

  return ($colour, $graphs, $graphs2, $colour2, $style);
}

sub ircbit{
  my ($name, $text) = @_;

  $name = " " . $name if $name =~ /^\d/;

  if ($colour) {
    return "$colour$name$colour2\[$text$colour2\]";
  } else {
    return "$name\[$text\]";
  }
}

sub firstline {
  my $file = shift;

  open(FILE, "<", $file) or return undef;
  chomp(my $line = <FILE>);
  close(FILE);

  return $line;
}

sub trim {
  my $s = shift;

  $s =~ s/^\s+|\s+$//g;

  return $s
}


sub percent {
  my $percent = ($_[1] != 0) ? sprintf("%.1f",(($_[0]/$_[1])*100)) : 0;

  if ($graphs) {
    my $tmp = "[";

    for (1..10) {
      if ($_ > sprintf("%.0f",$percent / 10)) {
        $tmp .= "-" if !defined $colour;
        $tmp .= "$graphs2-" if defined $colour;
      } else {
        $tmp .= "|" if !defined $colour;
        $tmp .= "$graphs|" if defined $colour;
      }
    }

    $tmp .= "]";
    return $percent."% ".$tmp;
  }

  return $percent."%";
}

sub get_basic_info() {
  my ($hostname, $kernel, $procs);

  chomp($hostname = `hostname`);
  chomp($kernel   = `uname -sr`);

  opendir(PROC, "/proc");
  $procs = scalar grep(/^\d/, readdir PROC);
  closedir(PROC);

  return ($hostname, $kernel, $procs);
}

sub get_uptime() {
  my $uptimeinfo = `uptime`;

  if ($uptimeinfo =~ /^\s+(\d+:\d+\w+|\d+:\d+:\d+)\s+up\s+(\d+)\s+day.?\W\s+(\d+):(\d+)\W\s+(\d+)\s+\w+\W\s+\w+\s+\w+\W\s+(\d+).(\d+)/igx) {
    return("$2 days, $3 hours, $4 minutes", $5, "$6.$7");
  } elsif ($uptimeinfo =~ /^\s+(\d+:\d+\w+|\d+:\d+:\d+)\s+up+\s+(\d+):(\d+)\W\s+(\d+)\s+\w+\W\s+\w+\s+\w+\W\s+(\d+).(\d+)/igx) {
    return("$2 hours, $3 minutes", $4, "$5.$6");
  } elsif ($uptimeinfo =~ /^\s+(\d+:\d+\w+|\d+:\d+:\d+)\s+up\s+(\d+)\s+day.?\W\s+(\d+)\s+min\W\s+(\d+)\s+\w+\W\s+\w+\s+\w+\W\s+(\d+).(\d+)/igx) {
    return("$2 days, $3 minutes", $4, "$5.$6");
  } elsif ($uptimeinfo =~ /^\s+(\d+:\d+\w+|\d+:\d+:\d+)\s+up+\s+(\d+)\s+min\W\s+(\d+)\s+\w+\W\s+\w+\s+\w+\W\s+(\d+).(\d+)/igx) {
    return("$2 minutes", $3, "$4.$5");
  }

  return undef;
}

sub get_os_release() {
  my %os_release_data;

  open(FILE, "<", "/usr/lib/os-release") or return undef;
  while (<FILE>) {
    chomp;

    if (/^\W*(\w+)=(?:["])?([A-Za-z0-9. :\/\-\(\)]+)(?:["])?(#.*)?$/) {
      $os_release_data{$1} = $2;
    }
  }
  close(FILE);

  return %os_release_data;
}

sub get_distro() {
  my $distro;
  my %os_release = get_os_release();

  if (defined $os_release{"NAME"}) {
    return $os_release{"NAME"}
        . " "
        . $os_release{"VERSION"};
  }

  if (-f "/etc/coas") {
    $distro = firstline("/etc/coas");
  } elsif (-f "/etc/environment.corel") {
    $distro = firstline("/etc/environment.corel");
  } elsif (-f "/etc/debian_version") {
    $distro = "Debian ".firstline("/etc/debian_version");
  } elsif (-f "/etc/mandrake-release") {
    $distro = firstline("/etc/mandrake-release");
  } elsif (-f "/etc/SuSE-release") {
    $distro = firstline("/etc/SuSE-release");
  } elsif (-f "/etc/turbolinux-release") {
    $distro = firstline("/etc/turbolinux-release");
  } elsif (-f "/etc/slackware-release") {
    $distro = firstline("/etc/slackware-release");
  } elsif (-f "/etc/redhat-release") {
    $distro = firstline("/etc/redhat-release");
  }

  return $distro;
}

sub get_mem_info() {
  my ($size, $free);

  open(MEMINFO, "<", "/proc/meminfo") or return undef;
  while (<MEMINFO>) {
    chomp;

    if (/MemTotal:\s+(\d+)/) {
      $size = sprintf("%0.2f", $1 / 1024);
    } elsif (/^MemFree:\s+(\d+)/) {
      $free = sprintf("%0.2f", $1 / 1024);
    }
  }
  close(MEMINFO);

  return ($size, $free);
}

sub get_swap_info() {
  my ($free, $size, $used);

  open(SWAPINFO, "<", "/proc/swaps") or return undef;
  while (<SWAPINFO>) {
    chomp;

    next if !/^\//;

    /\S+\s+\S+\s+(\S+)\s+(\S+)/;
    $size += $1;
    $used += $2;
  }
  close(SWAPINFO);

  $free = sprintf("%0.2f", ($size - $used) / 1024);
  $size = sprintf("%0.2f", $size / 1024);

  return ($size, $free);
}

sub get_cpu_info() {
  my ($model, $smp, $mhz, $lowmhz, $cache, $mips);

  open(CPUINFO, "<", "/proc/cpuinfo") or return undef;
  while (<CPUINFO>) {
    if (/^model name\s+\:\s+(.*?)$/) {
      if (defined $model) {
        if (defined $smp) {
          $smp++;
        } else {
          $smp = 2;
        }
      } else {
        $model = $1;
      }
    }

    if (/^cpu MHz\s+:\s+([\d\.]*)/) {
      if (defined $mhz) {
        if ($1 > $mhz) {
          $mhz = $1;
        }
      } else {
        $mhz = $1;
      }
      if (defined $lowmhz) {
        if ($1 < $lowmhz) {
          $lowmhz = $1;
        }
      } else {
        $lowmhz = $1;
      }
    }

    if (/^cache size\s+:\s+(.*)/) {
      $cache = $1;
    }

    if (/^bogomips\s+:\s+([\d\.]*)/) {
      $mips += $1;
    }
  }

  $model .= " ($smp threads)" if defined $smp;

  return ($model, $mhz, $lowmhz, $cache, $mips);
}

sub get_net_info() {
  my (%netinfo);

  open(NETINFO, "<", "/proc/net/dev") or return undef;
  while (<NETINFO>) {
    chomp;

    next if /^(\s+)?(Inter|face|lo)/;

    /^\s*(\w+):\s*(\d+)\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)\s+/;
    $netinfo{$1}{in} = sprintf("%.2f",$2 / 1048576);
    $netinfo{$1}{out} = sprintf("%.2f",$3 / 1048576);
  }
  close(NETINFO);

  return %netinfo;
}

sub get_disk_usage() {
  my ($total, $used);

  open(DF, "-|", "/usr/bin/df") or return undef;
  while (<DF>) {
    chomp;

    next if !/^\/dev\/\S+/;
    next if /(cd|cdrom|fd|floppy|tape)/;

    /^(\S+)\s+(\S+)\s+(\S+)/;
    next if not defined $2 or not defined $3;

    $total += $2;
    $used  += $3;
  }
  close(DF);

  $total = sprintf("%0.2f", $total / 1024);
  $used = sprintf("%0.2f", $used / 1024);

  return ($total, $used);
}

sub get_pci_info() {
  my ($vidcard, $ethernet);

  open(PCI, "-|", "/bin/lspci") or return undef;
  while (<PCI>) {
    chomp;

    if (/VGA compatible controller: (.*?)$/) {
      $vidcard .= "${1}+ ";
    } elsif (/(?:Ethernet|Network) controller: (.*?)$/) {
      $ethernet .= "${1}+ ";
    }
  }
  close(PCI);

  $vidcard =~ s/\+ $//;
  $ethernet =~ s/\+ $//;

  return ($vidcard, $ethernet);
}

sub get_screenres() {
  my ($res, $depth);

  open(DPY, "-|", "/usr/bin/xdpyinfo") or return undef;
  while (<DPY>) {
    chomp;

    if (/\s+dimensions:\s+(\S+)/) {
      $res   = $1;
    } elsif (/\s+depth:\s+(\S+)/) {
      $depth = $1;
    }
  }
  close(DPY);

  return ($res, $depth);
}

sub sysinfo {
  my @options = split(/ /, $_[0]);
  my %info;
  my ($hostname, $uname, $procs)          = get_basic_info();
  my ($distro)                            = get_distro();
  my ($uptime, $users, $loadavg)          = get_uptime();
  my ($memsize, $memfree)                 = get_mem_info();
  my ($swpsize, $swpfree)                 = get_swap_info();
  my ($dsksize, $dskused)                 = get_disk_usage();
  my ($model, $mhz, $lmhz, $cache, $mips) = get_cpu_info();
  my ($vidcard, $ethernet)                = get_pci_info();
  my %netinfo                             = get_net_info();
  my ($dpyres, $dpydepth);
  my $amhz = "$lmhz-$mhz";

  # Only care for this if DISPLAY is set
  ($dpyres, $dpydepth) = get_screenres() if $ENV{DISPLAY};

  # Make network stuff.
  ($colour, $graphs, $graphs2, $colour2, $style) = parseopts(\%netinfo, @options);

  if ($mhz == $lmhz) {
    $amhz = $mhz;
  }

  %info = (
    'os'       => "$uname - $distro",
    'up'       => $uptime,
    'cpu'      => "$model, $amhz MHz ($mips bogomips)",
    'mem'      => ($memsize-$memfree) . "/$memsize MiB (" . percent(($memsize-$memfree),$memsize) . ")",
    'host'     => $hostname,
    'users'    => $users,
    'load'     => $loadavg,
    'procs'    => $procs,
    'swap'     => ($swpsize-$swpfree) . "/$swpsize MiB (" . percent(($swpsize-$swpfree),$swpsize) . ")",
    'disk'     => "$dskused/$dsksize MiB (" . percent($dskused,$dsksize) . ")",
    'ethernet' => $ethernet,
);

  if ($ENV{DISPLAY}) {
    $info{'video'} = "$vidcard at $dpyres ($dpydepth bits)";
  }

  for (keys %netinfo) {
    $info{$_} - "in: $netinfo{$_}{in}MiB, out: $netinfo{$_}{out}MiB";
  }

  my $tmp;
  for (split(/ /, $style)) {
    $tmp .= ircbit($_, $info{$_}) . " ";
  }
  $tmp =~ s/ $//;

  Irssi::active_win()->command('say ' . $tmp);

  ($colour, $graphs, $graphs2, $colour2, $style) = undef;
}

sysinfo();

# sysinfo.pl ends here.
#
# Local Variables: ***
# mode:cperl ***
# End: ***

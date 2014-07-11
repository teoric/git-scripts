#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: loop-authors.pl
#
#        USAGE: ./loop-authors.pl  
#
#  DESCRIPTION: loop over authors in translation file and call
#               `mail-filer-par.sh` to set name and mail address for old
#               committer IDs.
#               (execute in working copy)
#
#       AUTHOR: Bernhard Fisseni (bfi), bernhard.fisseni@uni-due.de
# ORGANIZATION: Uni Duisburg-Essen
#      CREATED: 2014-07-08, 11:29:02 (CEST)
#  Last Change: 2014-07-11, 22:36:09 CEST
#===============================================================================

use strict;
use warnings;
use utf8;
use open qw( :encoding(UTF-8) :std );


# use charnames qw( :full :short );
use feature qw(say state switch unicode_strings);
use re "/u";
use autodie;

use Cwd 'abs_path';
use File::Basename;
my $script_path = dirname(abs_path($0));

# these must exist alongside the current script:
my $file = "$script_path/authors-transform.txt";
my $filter = "$script_path/filter-mail-par.sh";
open(my $authors, "<", $file);

# use v5.14;

my %authors;

while (<$authors>){
    next if m/^\s*#/;  # name commented out
    if (m/^\s*(?<short>.*?)\s*=\s*(?<name>.*?)\s*<(?<email>.*?)>/){
        next if ($+{name} eq $+{short});
        # say $+{short}, " + ", $+{name}, " + ", $+{email};
        $authors{$+{short}} = [$+{name}, $+{email}];
    }
}

for my $author (sort(keys %authors)){
    my ($name, $email) = @{$authors{$author}};
    say STDERR $name;
    system($filter, $author, $name, $email) == 0
        or break;
}



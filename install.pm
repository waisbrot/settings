# -*- mode: cperl; -*-
use strict;
use warnings;

use File::Basename qw/dirname/;
use File::Listing qw/parse_dir/;
use File::Copy qw/move/;

sub dolink {
  my ($reference_file, $target_file, $backup_file) = @_;
  if (-e $target_file) {
    print "Move aside $target_file -> $backup_file\n";
    die "Backup file $backup_file exists" if (-e $backup_file);
    die unless move($target_file, $backup_file);
  }
  print "Link $reference_file -> $target_file\n";
  die "Target file $target_file exists" if (-e $target_file);
  die if system "ln -s $reference_file $target_file";
}

sub rmlink {
  my ($reference_file, $target_file, $backup_file) = @_;
  if (-l $target_file) {
    print "Remove symlink $target_file\n";
    system "rm $target_file";
  }
}

# Given two linked directories, a reference and a target, put the
# reference into the target. Simple files will be symlinked, directories
# will be copied, directories that begin with an underscore will have the
# rest of their name prepended to their immediate children.
# Recurse into subdirs.
#
# mkdir_or_link(<file action>, <prefix>, <reference dir>, <target dir>, <backup dir>)
sub mkdir_or_link {
  my ($action, $prefix, $reference, $target, $backup) = @_;
  foreach my $dir (parse_dir(`ls -l $reference`)) {
    my ($name, $type, $size, $mtime, $mode) = @$dir;
    my $reference_file = "$reference/$name";
    my $target_file = "$target/${prefix}${name}";
    my $backup_file = "$backup/${prefix}${name}";
    if ($type eq "f") {  # simple file
      $action->($reference_file, $target_file, $backup_file);
    } elsif ($type eq "d") {
      if (substr($name, 0, 1) eq "_") {
	mkdir_or_link($action, substr($name, 1), $reference_file, $target, $backup);
      } else {
	die if system "mkdir -p $target_file";
	mkdir_or_link($action, "", $reference_file, $target_file, $backup_file);
      }
    }
  }
}

my $HOME = $ENV{HOME} or die "Can't figure out your HOME";
my $oldfiles = "$HOME/old-settings";
my $settingsdir = "$ENV{PWD}/".dirname($0);

my $command = shift or die "Usage: $0 <install|unlink>\n";

if ($command eq 'install') {
  if (-e $oldfiles) {
    die "Directory of old settings already exists: $oldfiles";
  }
  die unless mkdir $oldfiles;
  mkdir_or_link(\&dolink, "", $settingsdir, $HOME, $oldfiles);
} elsif ($command eq 'unlink') {
  mkdir_or_link(\&rmlink, "", $settingsdir, $HOME, $oldfiles);
} else {
  die "Usage $0 <install|unlink>\n";
}



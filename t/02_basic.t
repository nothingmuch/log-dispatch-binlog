#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Log::Dispatch::Binlog::File';
use ok 'Log::Dispatch::Binlog::Handle';

use File::Temp;

use Storable qw(fd_retrieve);

{
	my $tmp = File::Temp->new( UNLINK => 1 );

	my $file = Log::Dispatch::Binlog::File->new(
		min_level => "debug",
		name => "file",
		filename => $tmp->filename,
	);

	isa_ok( $file, "Log::Dispatch::File" );

	$file->log_message( my %p = ( level => "warn", message => "blah", name => "file" ) );

	open my $fh, "<", $tmp->filename;

	is_deeply(
		fd_retrieve($fh),
		\%p,
		"stored to file",
	);
}

{
	my $tmp = File::Temp->new( UNLINK => 1 );

	my $file = Log::Dispatch::Binlog::Handle->new(
		min_level => "debug",
		name => "handle",
		handle => $tmp,
	);

	$tmp->autoflush(1);

	isa_ok( $file, "Log::Dispatch::Handle" );

	$file->log_message( my %p = ( level => "warn", message => "blah", name => "handle" ) );

	open my $fh, "<", $tmp->filename;

	is_deeply(
		fd_retrieve($fh),
		\%p,
		"stored to file",
	);
}

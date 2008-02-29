#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
	NAME         => '',
	VERSION_FROM => '',
	INSTALLDIRS  => 'site',
	SIGN         => 1,
	PL_FILES     => { },
	PREREQ_PM    => {
		'Test::use::ok' => 0,
		'Log::Dispatch::File' => 0,
		'Log::Dispatch::Handle' => 0,
		'Storable' => 0,
		'File::Temp' => 0,
	},
);


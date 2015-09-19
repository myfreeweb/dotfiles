#!/usr/bin/env perl
# http://bob.cakebox.net/osxcompose.php

use strict;
use warnings;
use 5.010;

our $composekey = 0xf710; # F13

our %Keysyms;

use charnames ();
use List::MoreUtils qw(firstidx);
use X11::Keysyms '%Keysyms', ('MISCELLANY', 'XKB_KEYS', '3270', 'LATIN1', 'LATIN2', 'LATIN3', 'LATIN4', 'KATAKANA', 'ARABIC', 'CYRILLIC', 'GREEK', 'TECHNICAL', 'SPECIAL', 'PUBLISHING', 'APL', 'HEBREW', 'THAI', 'KOREAN');

binmode(STDIN, ':utf8'); binmode(STDOUT, ':utf8'); binmode(STDERR, ':utf8');

my %keys;

while( my $line = <STDIN> ){
	parseline($line);
}

output(\%keys);

exit 0;

sub parseline {
	my $line = shift;

	chomp($line);

	#
	# Parse line
	#

	my @tokens = $line =~ /\"[^\"]+\"|\S+/g;

	# Strip comments
	for my $i ( 0 .. $#tokens ){
		if( $tokens[$i] =~ /^#/ ){
			splice(@tokens, $i);
			last;
		}
	}

	return unless @tokens;
			
	my $colonidx = firstidx { $_ eq ':' } @tokens;

	my @events = @tokens[0 .. $colonidx-1];
	my @results = @tokens[$colonidx+1 .. $#tokens];

	#
	# Decode events
	#

	# Skip all but combinations starting with multi_key (dead keys)
	return unless $events[0] eq '<Multi_key>';

	# Skip all combinations involving dead keys
	return if grep { /^<dead_/ } @events;

	@events = map { /<Multi_key>/ ? $composekey : $_ } @events;
	@events = map { /<U([0-9a-fA-F]+)>/ ? hex($1) : $_ } @events;
	@events = map { /<(.*)>/ ? $Keysyms{$1} // $_ : $_ } @events;

	# Now skip the combinations if there are unknown keysyms
	return if grep { /^</ } @events;

	@events = map { chr } @events;

	#
	# Decode results
	#

	my $result;
	if( $results[0] =~ /^"(.*)"$/ ){
		$result = $1;
		$result =~ s/\\([0-7]+)/oct($1)/ge;
		$result =~ s/\\(0x[0-9a-zA-Z]+)/oct($1)/ge;
	}
	else {
		die 'unimplemented case';
	}

	#
	# Put into output structure
	#

	# WARNING: interesting use of references ahead.
	#
	# Create a multilevel hash like this from events:
	# %keys = (compose => {a => { e => 'aelig' } })

	my $ref = \\%keys;
	foreach( @events ){
		$ref = \$$ref->{$_};
	}
	$$ref = $result;
}

sub output {
	my $data = shift;
	my @stack = @_;

	my $indent = @stack;

	if( ref $data ){
		print "{\n";
		foreach my $key ( sort keys %$data ){
			my $indent = $indent + 1;
			print "\t" x $indent;
			printf '"\U%04X" = ', ord($key);

			output($data->{$key}, @stack, $key);
		}

		# Closing brace except for root dictionary where
		# that's a syntax error
		if( $indent ){
			print "\t" x $indent;
			print "};\n";
		}
		else {
			print "}\n";
		}
	}
	else {
		printf '("insertText:", "\U%04X");', ord $data;
		print ' /* ';
		print join(', ', map { ord $_ == $composekey ? 'Compose' : charnames::viacode(ord $_) // 'unknown' } @stack);
		print ': ';
		print charnames::viacode(ord $data);
		print ' */';
		print "\n";
	}
}	

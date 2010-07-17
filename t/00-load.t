#!/usr/bin/env perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Catalyst::TraitFor::Request::IsRESTy' );
}

diag( "Testing Catalyst::TraitFor::Request::IsRESTy $Catalyst::TraitFor::Request::IsRESTy::VERSION, Perl $], $^X" );

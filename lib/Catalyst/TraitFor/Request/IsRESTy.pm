#############################################################################
#
# Author:  Chris Weyl (cpan:RSRCHBOY), <cweyl@alumni.drew.edu>
# Company: No company, personal work
#
# Copyright (c) 2010  <cweyl@alumni.drew.edu>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
#############################################################################

package Catalyst::TraitFor::Request::IsRESTy;

use Moose::Role;
use namespace::autoclean;
use MooseX::ClassAttribute;

our $VERSION = '0.001_01';

with 'Catalyst::TraitFor::Request::REST';

class_has resty_builder => (
    traits => ['Code'], is => 'rw', isa => 'CodeRef',
    clearer => 'reset_resty_builder',
    default => sub { \&_build_is_resty_DEFAULT },
    handles => { _build_is_resty => 'execute_method' },
);

has is_resty => (
    is => 'ro', isa => 'Bool', lazy => 1, init_arg => undef,
    builder => '_build_is_resty',
);

# FIXME .... not optimal.

sub _build_is_resty_DEFAULT {
    my $self = shift @_;

    warn $self->preferred_content_type;
    return 0 if $self->preferred_content_type eq 'text/html';

    return 1;
}

1;

__END__

=head1 NAME

Catalyst::TraitFor::Request::IsRESTy - Request class trait for potentially "RESTy" requests

=head1 SYNOPSIS

    # in your application class...
    use CatalystX::RoleApplicator;
    __PACKAGE__->apply_request_class_roles(qw{
        Catalyst::TraitFor::Request::IsRESTy
    });

    # elsewhere...
    sub foo : Local {
        my ($self, $c) = @_;

        if ($c->req->is_resty) {

            # do stuff if we look like a REST request
        }

    }

=head1 DESCRIPTION

IsRESTy is a L<Catalyst::Request> trait that (essentially) adds an is_resty()
method, which attempts to determine if the request "looks" like a REST
request.  This can be useful when, say, combining public and serialized
actions in a single controller, where certain actions do / do not need to be
executed based on the type of the request.

Right now, the "sniffing" logic is pretty simplistic: if the request indicates
a preferred content type of anything but text/html, we're resty.

=head1 METHODS

=head2 is_resty()

Returns true/false depending on our guess of this request's RESTiness.

=head1 SETUP METHODS

=head2 resty_builder()

Gets or sets the method used to test the request for its RESTiness.  Note that
this controls the method used across all instances. (That is, this is a method
set at the class level.)

=head2 reset_resty_builder()

Return the tester to its default.

=head1 SEE ALSO

L<Catalyst::Controller::Resources>, L<Catalyst::Controller::REST> can both be
used together to present an effective "merged" controller.

L<CatalystX::RoleApplicator>, L<Catalyst::TraitFor::Request::REST>.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2010 Chris Weyl <cweyl@alumni.drew.edu>

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the

    Free Software Foundation, Inc.
    59 Temple Place, Suite 330
    Boston, MA  02111-1307  USA

=cut

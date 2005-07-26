package WebGUI::Form::zipcode;

=head1 LEGAL

 -------------------------------------------------------------------
  WebGUI is Copyright 2001-2005 Plain Black Corporation.
 -------------------------------------------------------------------
  Please read the legal notices (docs/legal.txt) and the license
  (docs/license.txt) that came with this distribution before using
  this software.
 -------------------------------------------------------------------
  http://www.plainblack.com                     info@plainblack.com
 -------------------------------------------------------------------

=cut

use strict;
use base 'WebGUI::Form::text';
use WebGUI::Session;
use WebGUI::Style;

=head1 NAME

Package WebGUI::Form::zipcode

=head1 DESCRIPTION

Creates a zip code form field. 

=head1 SEE ALSO

This is a subclass of WebGUI::Form::text.

=head1 METHODS 

The following methods are specifically available from this class. Check the superclass for additional methods.

=cut

#-------------------------------------------------------------------

=head2 definition ( [ additionalTerms ] )

See the superclass for additional details.

=head3 additionalTerms

The following additional parameters have been added via this sub class.

=head4 maxlength

Defaults to 10. Determines the maximum number of characters allowed in this field.

=cut

sub definition {
	my $class = shift;
	my $definition = shift || [];
	push(@{$definition}, {
		maxlength=>{
			defaultValue=> 10
			}
		});
	return $class->SUPER::definition($definition);
}

#-------------------------------------------------------------------

=head2 getValueFromPost ( )

Returns a validated form post result. If the result does not pass validation, it returns undef instead.

=cut

sub getValueFromPost {
	my $self = shift;
	my $value = $session{cgi}->param($self->{name});
   	if ($value =~ /^[A-Z\d\s\-]+$/) {
                return $value;
        }
        return undef;
}

#-------------------------------------------------------------------

=head2 toHtml ( )

Renders an input tag of type text.

=cut

sub toHtml {
        my $self = shift;
	WebGUI::Style::setScript($session{config}{extrasURL}.'/inputCheck.js',{ type=>'text/javascript' });
	$self->{extras} .= ' onkeyup="doInputCheck(this.form.'.$self->{name}.',\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ- \')"';
	return $self->SUPER::toHtml;
}

1;


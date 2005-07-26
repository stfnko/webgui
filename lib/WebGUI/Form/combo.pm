package WebGUI::Form::combo;

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
use base 'WebGUI::Form::selectList';
use WebGUI::Form::text;
use WebGUI::International;
use WebGUI::Session;

=head1 NAME

Package WebGUI::Form::combo

=head1 DESCRIPTION

Creates a select list merged with a text box form control.

=head1 SEE ALSO

This is a subclass of WebGUI::Form::selectList.

=head1 METHODS 

The following methods are specifically available from this class. Check the superclass for additional methods.

=cut


#-------------------------------------------------------------------

=head2 getValueFromPost ( )

Returns an array or a carriage return ("\n") separated scalar depending upon whether you're returning the values into an array or a scalar.

=cut

sub getValueFromPost {
	my $self = shift;
	if ($session{cgi}->param($self->{name}."_new")) {
		return $session{cgi}->param($self->{name}."_new");
        }
	return $self->SUPER::getValueFromPost;
}

#-------------------------------------------------------------------

=head2 toHtml ( )

Renders a combo box form control.

=cut

sub toHtml {
	my $self = shift;
	$self->{options}->{''} = '['.WebGUI::International::get(582).']';
        $self->{options}->{_new_} = WebGUI::International::get(581).'-&gt;';
	return $self->SUPER::toHtml
		.WebGUI::Form::text->new(
			size=>$session{setting}{textBoxSize}-5,
			name=>$self->{name}."_new"
			)->toHtml;
}



1;


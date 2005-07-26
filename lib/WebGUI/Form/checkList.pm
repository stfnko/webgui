package WebGUI::Form::checkList;

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
use base 'WebGUI::Form::Control';
use WebGUI::Form::checkbox;
use WebGUI::Session;

=head1 NAME

Package WebGUI::Form::checkList

=head1 DESCRIPTION

Creates a series of check box form fields.

=head1 SEE ALSO

This is a subclass of WebGUI::Form::Control. Also take a look ath WebGUI::Form::checkbox as this class creates a list of checkboxes.

=head1 METHODS 

The following methods are specifically available from this class. Check the superclass for additional methods.

=cut

#-------------------------------------------------------------------

=head2 definition ( [ additionalTerms ] )

See the super class for additional details.

=head3 additionalTerms

The following additional parameters have been added via this sub class.

=head4 options

A hash reference containing key values that will be returned with the form post and displayable text pairs. Defaults to an empty hash reference.

=head4 defaultValue

An array reference of the items to be checked if no value is specified. Defaults to an empty array reference.

=head4 vertical

Boolean representing whether the checklist should be represented vertically or horizontally. If set to "1" will be displayed vertically. Defaults to "0".

=cut

sub definition {
	my $class = shift;
	my $definition = shift || [];
	push(@{$definition}, {
		options=>{
			defaultValue=>{}
			},
		defaultValue=>{
			defaultValue=>[],
			},
		vertical=>{
			defaultValue=>0
			}
		});
	return $class->SUPER::definition($definition);
}


#-------------------------------------------------------------------

=head2 getValueFromPost ( )

Returns an array or a carriage return ("\n") separated scalar depending upon whether you're returning the values into an array or a scalar.

=cut

sub getValueFromPost {
	my $self = shift;
	my @data = $session{cgi}->param($self->{name});
        return wantarray ? @data : join("\n",@data);
}

#-------------------------------------------------------------------

=head2 toHtml ( )

Renders a series of checkboxes.

=cut

sub toHtml {
	my $self = shift;
	my $output;
	foreach my $key (keys %{$self->{options}}) {
                my $checked = 0;
                foreach my $item (@{$self->{value}}) {
                        if ($item eq $key) {
                                $checked = 1;
                        }
                }
                $output .= WebGUI::Form::checkbox->new({
                        name=>$self->{name},
                        value=>$key,
                        extras=>$self->{extras},
                        checked=>$checked
                        })->toHtml;
                $output .= ${$self->{options}}{$key};
                if ($self->{vertical}) {
                        $output .= "<br />\n";
                } else {
                        $output .= " &nbsp; &nbsp;\n";
                }
        }
        return $output;
}



1;


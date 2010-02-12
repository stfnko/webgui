package WebGUI::Asset::Wobject::Search;

#-------------------------------------------------------------------
# WebGUI is Copyright 2001-2009 Plain Black Corporation.
#-------------------------------------------------------------------
# Please read the legal notices (docs/legal.txt) and the license
# (docs/license.txt) that came with this distribution before using
# this software.
#-------------------------------------------------------------------
# http://www.plainblack.com                     info@plainblack.com
#-------------------------------------------------------------------

use strict;
use WebGUI::Definition::Asset;
extends "WebGUI::Asset::Wobject";
aspect assetName => ['assetName', 'Asset_Search'];
aspect icon      => 'search.gif';
aspect tableName => 'search';
property templateId => (
                fieldType       => "template",
                default         => 'PBtmpl0000000000000200',    
                tab             => "display",
                namespace       => "Search",
                hoverHelp       => ['search template description', 'Asset_Search'],
                label           => ['search template', 'Asset_Search'],
         );
property searchRoot => (
                fieldType       => "asset",
                builder         => '_searchRoot_builder',
                tab             => "properties",
                hoverHelp       => ["search root description", 'Asset_Search'],
                label           => ['search root', 'Asset_Search'],
         );
sub _searchRoot_builder {
    my $session = shift->session;
    return $session->setting->get("defaultPage");
}
property classLimiter => (
                fieldType       => "checkList",
                default         => undef,
                vertical        => 1,
                tab             => "properties",
                hoverHelp       => ["class limiter description", 'Asset_Search'],
                label           => ["class limiter", 'Asset_Search'],
                options         => \&_classLimiter_options,
                showSelectAll   => 1,
         );
sub _classLimiter_options {
    my $session = shift->session;
    return $session->db->buildHashRef("select distinct(className) from asset");
}
property useContainers => (
                tab             => "properties",
                hoverHelp       => ["useContainers help", 'Asset_Search'],
                label           => ["useContainers", 'Asset_Search'],
                fieldType       => "yesNo",
                default         => 0,
         );
property paginateAfter => (
                hoverHelp       => ["paginate after help", 'Asset_Search'],
                label           => ["paginate after", 'Asset_Search'],
                tab             => "display",
                fieldType       => "integer",
                default         => 25,
         );



use Tie::IxHash;
use WebGUI::International;
use WebGUI::Paginator;
use WebGUI::Search;
use HTML::Highlight;

=head1 NAME

Package WebGUI::Asset::Wobject::Search

=head1 DESCRIPTION

Asset used to search WebGUI content.

=head1 METHODS

These methods are available from this package:

=cut


#-------------------------------------------------------------------

=head2 definition ( class, definition )

This method defines all properties of a Search and is used to autogenerate most methods.

=head3 class

$class is used to make sure that inheritance works on Assets and Wobjects.

=head3 definition

Definition hashref from subclasses.

=head3 Search specific properties

These properties are added just for this asset.

=head4 templateId

ID of a tempate from the Search namespace to display the search results.

=head4 searchRoot

An asset id of the point at which a search should start.

=head4 classLimiter

An array reference of asset classnames that are valid for the search.

=cut

sub definition {
	my $class = shift;
	my $session = shift;
	my $definition = shift;
	my $i18n = WebGUI::International->new($session,'Asset_Search');
	my %properties;
	tie %properties, 'Tie::IxHash';
	%properties = (
 		);

	push(@{$definition}, {
		className=>'WebGUI::Asset::Wobject::Search',
		properties=>\%properties
		});
        return $class->SUPER::definition($session, $definition);
}

#-------------------------------------------------------------------

=head2 prepareView ( )

See WebGUI::Asset::prepareView() for details.

=cut

sub prepareView {
    my $self = shift;
    $self->SUPER::prepareView();
    my $template = WebGUI::Asset::Template->new($self->session, $self->templateId);
    if (!$template) {
        WebGUI::Error::ObjectNotFound::Template->throw(
            error      => qq{Template not found},
            templateId => $self->templateId,
            assetId    => $self->getId,
        );
    }
    $template->prepare($self->getMetaDataAsTemplateVariables);
    $self->{_viewTemplate} = $template;
}


#-------------------------------------------------------------------

=head2 view ( )

Display search interface and results.

=cut

sub view {
	my $self    = shift;
    my $session = $self->session;
    my $form    = $session->form;
    my $user    = $session->user;
	my $i18n    = WebGUI::International->new($self->session, "Asset_Search");

    my $keywords = $form->get("keywords");
	my %var;
	
    $var{'form_header'  } = WebGUI::Form::formHeader($session, {
        action => $self->getUrl,
        method => "GET"
		})
    .WebGUI::Form::hidden($self->session,{name=>"doit", value=>"1"});
	$var{'form_footer'  } = WebGUI::Form::formFooter($session);
	$var{'form_submit'  } = WebGUI::Form::submit($session, {
        value=>$i18n->get("search")
    });
	$var{'form_keywords'} = WebGUI::Form::text($session, {
        name=>"keywords",
        value=>$keywords
    });
	$var{'no_results'   } = $i18n->get("no results");
	
    if ($form->get("doit")) {
		my $search = WebGUI::Search->new($session);
		my %rules   = (
			keywords =>$keywords, 
			lineage  =>[
                WebGUI::Asset->newById($session,$self->searchRoot)->get("lineage")
            ],
		);
		my @classes     = split("\n",$self->classLimiter);
		$rules{classes} = \@classes if (scalar(@classes));
		$search->search(\%rules);
		
        #Instantiate the highlighter
        my @words     = split(/\s+/,$keywords);
        my @wildcards = map { "%" } @words;
        my $hl = HTML::Highlight->new(
            words     => \@words,
            wildcards => \@wildcards
        );

        #Set up the paginator
        my $p         = $search->getPaginatorResultSet (
            $self->getUrl('doit=1;keywords='.$session->url->escape($keywords)),
			$self->paginateAfter,
        );

        my @results   = ();
        foreach my $data (@{$p->getPageData}) {
            next unless (
                $user->userId eq $data->{ownerUserId}
                || $user->isInGroup($data->{groupIdView})
                || $user->isInGroup($data->{groupIdEdit})
            );

            my $asset = WebGUI::Asset->new($session, $data->{assetId}, $data->{className});
            if (defined $asset) {
                my $properties = $asset->get;
                if ($self->useContainers) {
                    $properties->{url} = $asset->getContainer->url;
                }
                #Add highlighting
                $properties->{'title'               } = $hl->highlight($properties->{title} || '');
                $properties->{'title_nohighlight'   } = $properties->{title};
                my $synopsis = $data->{'synopsis'} || '';
                WebGUI::Macro::process($self->session, \$synopsis);
                $properties->{'synopsis'            } = $hl->highlight($synopsis);
                $properties->{'synopsis_nohighlight'} = $synopsis;
                push(@results, $properties);
                $var{results_found} = 1;
            } 
		}

        $var{result_set} = \@results;
        $p->appendTemplateVars(\%var);
		
	}
	return $self->processTemplate(\%var, undef, $self->{_viewTemplate});
}

1;


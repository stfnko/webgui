#-------------------------------------------------------------------
# WebGUI is Copyright 2001-2006 Plain Black Corporation.
#-------------------------------------------------------------------
# Please read the legal notices (docs/legal.txt) and the license
# (docs/license.txt) that came with this distribution before using
# this software.
#-------------------------------------------------------------------
# http://www.plainblack.com                     info@plainblack.com
#-------------------------------------------------------------------

use FindBin;
use strict;
use lib "$FindBin::Bin/../../lib";

##The goal of this test is to test the creation of Article Wobjects.

use WebGUI::Test;
use WebGUI::Session;
use Test::More tests => 21; # increment this value for each test you create
use WebGUI::Asset::Wobject::Article;

my $session = WebGUI::Test->session;

# Do our work in the import node
my $node = WebGUI::Asset->getImportNode($session);

# Lets create an article wobject using all defaults then test to see if those defaults were set
my $articleDefaults = {
	cacheTimeout => 3600,
	templateId   => 'PBtmpl0000000000000002',
	linkURL	     => undef,
	linkTitle    => undef,
	storageId    => undef,
};

my $versionTag = WebGUI::VersionTag->getWorking($session);
$versionTag->set({name=>"Article Test"});
my $article = $node->addChild({className=>'WebGUI::Asset::Wobject::Article'});

# Test for a sane object type
isa_ok($article, 'WebGUI::Asset::Wobject::Article');

# Test to see if all of the default properties are correct
foreach my $defaultProperty (keys %{$articleDefaults}) {
	is ($article->get($defaultProperty), $articleDefaults->{$defaultProperty}, "default $defaultProperty is ".$articleDefaults->{$defaultProperty});
}

# Test to see if we can set new values
my $newArticleSettings = {
	cacheTimeout => 124,
	templateId   => "PBtmpl0000000000000084",
	linkURL      => "http://www.snapcount.org",
	linkTitle    => "I'm thinking of getting metal legs",
	storageId    => "ThisIsNotRealStorageId",
};
$article->update($newArticleSettings);

foreach my $newSetting (keys %{$newArticleSettings}) {
	is ($article->get($newSetting), $newArticleSettings->{$newSetting}, "updated $newSetting is ".$newArticleSettings->{$newSetting});
}

TODO: {
        local $TODO = "Tests to make later";
        ok(0, 'Test duplicate method');
        ok(0, 'Test exportAssetData method');
	ok(0, 'Test getStorageLocation method');
	ok(0, 'Test indexContent method');
	ok(0, 'Test purge method');
	ok(0, 'Test purgeCache method');
	ok(0, 'Test purgeRevision method');
	ok(0, 'Test view method... maybe?');
	ok(0, 'Test www_deleteFile method');
	ok(0, 'Test www_view method... maybe?');
}

END {
	# Clean up after thy self
	$versionTag->rollback($versionTag->getId);
}


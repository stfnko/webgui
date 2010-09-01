# vim:syntax=perl
#-------------------------------------------------------------------
# WebGUI is Copyright 2001-2009 Plain Black Corporation.
#-------------------------------------------------------------------
# Please read the legal notices (docs/legal.txt) and the license
# (docs/license.txt) that came with this distribution before using
# this software.
#------------------------------------------------------------------
# http://www.plainblack.com                     info@plainblack.com
#------------------------------------------------------------------

# Write a little about what this script tests.
# 
#

use strict;
use Test::More;
use Test::Deep;
use Exception::Class;

use WebGUI::Test; # Must use this before any other WebGUI modules
use WebGUI::Session;
use WebGUI::Text;
use WebGUI::Shop::AddressBook;

#----------------------------------------------------------------------------
# Init
my $session         = WebGUI::Test->session;

#----------------------------------------------------------------------------
# Tests

plan tests => 23;

#----------------------------------------------------------------------------
# put your tests here

my $storage;
my $e;
my $book;

#######################################################################
#
# new
#
#######################################################################

eval { $book = WebGUI::Shop::AddressBook->new(); };
$e = Exception::Class->caught();
isa_ok($e, 'WebGUI::Error::InvalidParam', 'new takes exception to not giving it a session object');
cmp_deeply(
    $e,
    methods(
        error    => 'Need a session.',
        expected => 'WebGUI::Session',
        got      => '',
    ),
    'new takes exception to not giving it a session object',
);

$session->user({userId => 3});
eval { $book = WebGUI::Shop::AddressBook->new($session, 'neverAGUID'); };
$e = Exception::Class->caught();
isa_ok($e, 'WebGUI::Error::ObjectNotFound', 'new takes exception to not giving it an existing addressBookId');
cmp_deeply(
    $e,
    methods(
        error => 'No such address book.',
        id    => 'neverAGUID',
    ),
    'new takes exception to not giving it a addressBook Id',
);
$session->user({userId => 1});


eval { $book = WebGUI::Shop::AddressBook->new($session); };
$e = Exception::Class->caught();
isa_ok($e, 'WebGUI::Error::InvalidParam', 'new takes exception to making an address book for Visitor');
cmp_deeply(
    $e,
    methods(
        error    => 'Visitor cannot have an address book.',
    ),
    '... correct error message',
);

$session->user({userId => 3});
$book = WebGUI::Shop::AddressBook->new($session);
isa_ok($book, 'WebGUI::Shop::AddressBook', 'new returns the right kind of object');

isa_ok($book->session, 'WebGUI::Session', 'session method returns a session object');

is($session->getId, $book->session->getId, 'session method returns OUR session object');

ok($session->id->valid($book->getId), 'new makes a valid GUID style addressBookId');

is($book->get('userId'), 3, 'new uses $session->user to get the userid for this book');
is($book->userId, 3, '... testing direct accessor');

my $bookCount = $session->db->quickScalar('select count(*) from addressBook');
is($bookCount, 1, 'only 1 address book was created');

my $alreadyHaveBook = WebGUI::Shop::AddressBook->new($session);
isnt($book->getId, $alreadyHaveBook->getId, 'creating an addressbook, even when you already have one, always returns a new one');

#######################################################################
#
# getId
#
#######################################################################

is($book->getId, $book->get('addressBookId'), 'getId is a shortcut for ->get');

#######################################################################
#
# addAddress
#
#######################################################################

my $address1 = $book->addAddress({ label => q{Red's cell} });
isa_ok($address1, 'WebGUI::Shop::Address', 'addAddress returns an object');

my $address2 = $book->addAddress({ label => q{Norton's office} });

#######################################################################
#
# getAddresses
#
#######################################################################

my @addresses = @{ $book->getAddresses() };

cmp_bag(
    [ map { $_->getId } @addresses ],
    [$address1->getId, $address2->getId],
    'getAddresses returns all address objects for this book'
);

#######################################################################
#
# update
#
#######################################################################

$book->update({ lastShipId => $address1->getId, lastPayId => $address2->getId});

cmp_deeply(
    $book->get(),
    {
        userId           => ignore(),
        addressBookId    => ignore(),
        defaultAddressId => ignore(),
    },
    'update does not add new properties to the object'
);

my $bookClone = WebGUI::Shop::AddressBook->new($session, $book->getId);

delete $book->{_addressCache};
cmp_deeply(
    $bookClone,
    $book,
    'update updates the db, too'
);

#######################################################################
#
# delete
#
#######################################################################

$alreadyHaveBook->delete();
$bookCount = $session->db->quickScalar('select count(*) from addressBook');
my $addrCount = $session->db->quickScalar('select count(*) from address');

is($bookCount, 1, 'delete: one book deleted');

$bookClone->delete();
$bookCount = $session->db->quickScalar('select count(*) from addressBook');
$addrCount = $session->db->quickScalar('select count(*) from address');

is($bookCount, 0, '... book deleted');
is($addrCount, 0, '... also deletes addresses in the book');
undef $book;

#######################################################################
#
# newByUserId
#
#######################################################################


my $otherSession = WebGUI::Test->newSession;
my $mergeUser    = WebGUI::User->create($otherSession);
WebGUI::Test->addToCleanup($mergeUser);
$otherSession->user({user => $mergeUser});
my $adminBook   = WebGUI::Shop::AddressBook->new($otherSession);
WebGUI::Test->addToCleanup($adminBook);
my $goodAddress = $adminBook->addAddress({label => 'first'});

my $session2 = WebGUI::Test->newSession;
$session2->user({user => $mergeUser});
my $bookAdmin = WebGUI::Shop::AddressBook->newByUserId($session2);
WebGUI::Test->addToCleanup($bookAdmin);

cmp_bag(
    [ map { $_->getId } @{ $bookAdmin->getAddresses } ],
    [ $goodAddress->getId, ],
    'newByUserId works'
);

package Markdown::phpBB;

use 5.010;
use strict;
use warnings;
use autodie;
use Moose;

# ABSTRACT: Turn markdown into phpBB code
# VERSION

use Markdent::Parser;
use Markdown::phpBB::Handler;

my $handler = Markdown::phpBB::Handler->new;

my $parser = Markdent::Parser->new(
    handler => $handler,
    dialect => 'GitHub',
);

sub convert {
    my ($self, $text) = @_;

    $parser->parse(markdown => $text);

    return $handler->result;
}

1;

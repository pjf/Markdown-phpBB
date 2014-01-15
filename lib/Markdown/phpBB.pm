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

=head1 SYNOPSIS

    my $md2php = Markdown::phpBB->new;

    my $phpbb = $md2php->convert($markdown);

=head1 DESCRIPTION

This converts (github-flavoured) markdown into phpBB / BBcode.

It uses L<Markdown::phpBB::Handler> and L<Markdent> to do the
heavy lifting.

=cut

my $handler = Markdown::phpBB::Handler->new;

my $parser = Markdent::Parser->new(
    handler => $handler,
    dialect => 'GitHub',
);

=method convert

    my $phpbb = $md2php->convert($markdown);

Takes a single string in markdown format, and returns the equivalent
string in phpBB / BBcode.

=cut

sub convert {
    my ($self, $text) = @_;

    $parser->parse(markdown => $text);

    return $handler->result;
}

1;

=head1 BUGS

Plenty. Report them or fix them at
L<http://github.com/pjf/Markdown-phpBB/issues>.

=cut

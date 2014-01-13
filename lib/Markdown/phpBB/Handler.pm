package Markdown::phpBB::Handler;

# ABSTRACT: Turn Markdown into phpBB code

use 5.010;
use strict;
use warnings;

use Moose;
use Data::Dumper;

# VERSION

with 'Markdent::Role::Handler';

has _cached    => (is => 'rw', isa => 'Str', default => '');

sub handle_event {
    my ($self, $event) = @_;

    $self->add( $self->text_for_event($event) || "");
    
    return;
}

sub add {
    my ($self, $text) = @_;
    $self->_cached( $self->_cached . $text );
}

sub result {
    my ($self) = @_;

    my $cached = $self->_cached();

    $self->_cached(""); # Clear cache;

    $cached =~ s{\n\[/li\]}{[/li]\n}g; # Fix ugly list elements
    $cached =~ s{\s*$}{\n};            # Remove trailing whitespace

    return $cached;

}

my %tag = (
    document       => [    "",        ""      ],
    paragraph      => [    "",        "\n"    ],
    emphasis       => [ qw([i]       [/i])    ],
    strong         => [ qw([b]       [/b])    ],
    unordered_list => [   "[ul]\n", "[/ul]\n" ],
    list_item      => [ qw([li]      [/li] )  ],
    link           => [ qw([url]     [/url])  ],
);

sub text_for_event {
    my ($self, $event) = @_;

    my $name  = $event->event_name;
    my $start = $event->is_start;

    if ($name eq 'text') { return $event->text; }

    if ($name eq 'start_link' ) {
        my $url = $event->uri;
        return "[url=$url]";
    }

    if ($name eq 'image') {
        my $url = $event->uri;
        return "[spoiler][img]$url\[/img][/spoiler]"
    }

    $name =~ s/^(?:start|end)_//;
    if ($tag{$name}) { return $tag{$name}[$start ? 0 : 1]; }

    # Oh noes! Something went wrong.

    use Data::Dumper;
    warn "Unknown markdown event: ". $event->event_name . "\n";
    warn Dumper { $event->kv_pairs_for_attributes };

    return;

}

1;

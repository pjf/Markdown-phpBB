## md2phpBB

This software was done in the bare minimum time to scratch an itch I had.

If you ask me nicely, I'll write some docs and pop it on the CPAN.

I also *love* patches. Please send them to me. :)

## Installing:

This requires `Dist::Zilla` to install.

    $ git clone https://github.com/pjf/Markdown-phpBB.git
    $ cd Markdown-phpBB
    $ dzil install

## Running:

    $ md2phpbb somefile.md       # Convert from file
    $ echo "*Hello*" | md2phpbb  # ...or from STDIN

Output is always sent to STDOUT.

Of most use is `%!md2phpbb` in vim, which will replace your current
buffer (written in markdown) with the phpBB equivalent code.

# SPDX-License-Identifier: Artistic-1.0-Perl
# Copyright 2011, Simon Cozens & SIL International, All rights reserved.
package Text::Gr2;
use Text::Gr2::Face;
use Text::Gr2::Font;
use Text::Gr2::FeatureRef;
use Text::Gr2::FeatureVal;
use Text::Gr2::CharInfo;
use Text::Gr2::Segment;
use Text::Gr2::Slot;

use warnings;
use strict;

=head1 NAME

Text::Gr2 - Interface to SIL's Graphite2 rendering engine

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Text::Gr2', $VERSION);

sub _decode { my $c = pack("N*",$_[0]); $c=~/^[[:print:]]+/ ? $c : $_[0] }

=head1 SYNOPSIS

    use Text::Gr2;
    my $face = Text::Gr2::Face->open($fontfile, cache_size => 1000);
    my $sized_font = $face->make_font($dpi*$pointsize/72);
    my $seg = $sized_font->segment($face, $text);
    my @chars = $seg->cinfos;
    for ($seg->slots) {
        layout_text($_->origin_X, $_->origin_Y, $chars[$c++]->unicode_char);
    }

=head1 WHAT IS GRAPHITE?

Graphite is a I<back-end> rendering engine for complex, non-Roman
scripts. It will not lay out text for you. It I<will> help you to know
where characters in a string should be positioned - how wide accents
should be and where they go, what alternate character forms to use, and
so on.

B<This requires Graphite-enabled fonts>. Most fonts aren't; right now,
only a few fonts from the Graphite project itself are. See
http://graphite.sil.org for more details.

=head1 FUNCTIONS

For most purposes, the entry point to this API is through
C<< Text::Gr2::Face->open >>. The C<Text::Gr2> module itself
only provides two functions, for logging:

=head2 start_logging

    Text::Gr2->start_logging($face, $fname);

=head2 stop_logging

    END { Text::Gr2->stop_logging($face) }

Finishes writing the log for the given face.

=head1 INTERNAL METHODS

=head2 str_to_tag

=head2 tag_to_str

Convert between language/feature tags and ID numbers. This is
effectively done with a C<pack("N*")>.

=head1 SEE ALSO

L<Text::Gr2::Face>, L<Text::Gr2::FeatureRef>,
L<Text::Gr2::FeatureVal>, L<Text::Gr2::Font>,
L<Text::Gr2::Segment>

http://graphite.sil.org/

=cut

1; # End of Text::Gr2

__END__

=begin copyright

 SPDX-License-Identifier: Artistic-1.0-Perl
 Copyright 2011, Simon Cozens & SIL International, All rights reserved.

    Author: Simon Cozens <simon@cpan.org>

=end copyright

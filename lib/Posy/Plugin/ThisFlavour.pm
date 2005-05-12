package Posy::Plugin::ThisFlavour;
use strict;

=head1 NAME

Posy::Plugin::ThisFlavour - Posy plugin to change local links to the current flavour.

=head1 VERSION

This describes version B<0.42> of Posy::Plugin::ThisFlavour.

=cut

our $VERSION = '0.42';

=head1 SYNOPSIS

    @plugins = qw(Posy::Core Posy::Plugin::ThisFlavour));
    @entry_actions = qw(header
	    ...
	    parse_entry
	    ...
	    this_flavour
	    ...
	);

=head1 DESCRIPTION

This plugin changes local links in entries from the default flavour
into the current flavour (if the flavours are not the same).

=head2 Configuration

This expects configuration settings in the $self->{config} hash,
which, in the default Posy setup, can be defined in the main "config"
file in the data directory.

=over

=item B<this_flavour_convert_links>

Set this_flavour_convert_links to off (zero) to turn off this plugin
(for example, to give different behaviour in different directories).
(default: on)

=back

=cut

=head1 OBJECT METHODS

Documentation for developers and those wishing to write plugins.

=head2 init

Do some initialization; make sure that default config values are set.

=cut
sub init {
    my $self = shift;
    $self->SUPER::init();

    # set defaults
    $self->{config}->{this_flavour_convert_links} = 1
	if (!defined $self->{config}->{this_flavour_convert_links});
} # init

=head1 Entry Action Methods

Methods implementing per-entry actions.

=head2 this_flavour

$self->this_flavour($flow_state, $current_entry, $entry_state)

Alters $current_entry->{body} by converting the local links
to the current flavour.

=cut
sub this_flavour {
    my $self = shift;
    my $flow_state = shift;
    my $current_entry = shift;
    my $entry_state = shift;

    if ($self->{config}->{this_flavour_convert_links}
	&& ($self->{config}->{flavour} ne $self->{path}->{flavour}))
    {
	my $default_flavour = $self->{config}->{flavour};
	my $flavour = $self->{path}->{flavour};
	$current_entry->{body} =~ s/(href\s*=\s*"?(?!http:)[^">?#]+)\.${default_flavour}?([">?#\s]|$)/$1.${flavour}$2/sgi;
    }
    1;
} # this_flavour

=head1 INSTALLATION

Installation needs will vary depending on the particular setup a person
has.

=head2 Administrator, Automatic

If you are the administrator of the system, then the dead simple method of
installing the modules is to use the CPAN or CPANPLUS system.

    cpanp -i Posy::Plugin::ThisFlavour

This will install this plugin in the usual places where modules get
installed when one is using CPAN(PLUS).

=head2 Administrator, By Hand

If you are the administrator of the system, but don't wish to use the
CPAN(PLUS) method, then this is for you.  Take the *.tar.gz file
and untar it in a suitable directory.

To install this module, run the following commands:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

Or, if you're on a platform (like DOS or Windows) that doesn't like the
"./" notation, you can do this:

   perl Build.PL
   perl Build
   perl Build test
   perl Build install

=head2 User With Shell Access

If you are a user on a system, and don't have root/administrator access,
you need to install Posy somewhere other than the default place (since you
don't have access to it).  However, if you have shell access to the system,
then you can install it in your home directory.

Say your home directory is "/home/fred", and you want to install the
modules into a subdirectory called "perl".

Download the *.tar.gz file and untar it in a suitable directory.

    perl Build.PL --install_base /home/fred/perl
    ./Build
    ./Build test
    ./Build install

This will install the files underneath /home/fred/perl.

You will then need to make sure that you alter the PERL5LIB variable to
find the modules, and the PATH variable to find the scripts (posy_one,
posy_static).

Therefore you will need to change:
your path, to include /home/fred/perl/script (where the script will be)

	PATH=/home/fred/perl/script:${PATH}

the PERL5LIB variable to add /home/fred/perl/lib

	PERL5LIB=/home/fred/perl/lib:${PERL5LIB}

=head1 REQUIRES

    Posy
    Posy::Core

    Test::More

=head1 SEE ALSO

perl(1).
Posy

=head1 BUGS

Please report any bugs or feature requests to the author.

=head1 AUTHOR

    Kathryn Andersen (RUBYKAT)
    perlkat AT katspace dot com
    http://www.katspace.com

=head1 COPYRIGHT AND LICENCE

Copyright (c) 2004-2005 by Kathryn Andersen

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Posy::Plugin::ThisFlavour
__END__

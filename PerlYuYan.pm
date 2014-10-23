# $File: //member/autrijus/Lingua-Sinica-PerlYuYan/PerlYuYan.pm $ $Author: autrijus $
# $Revision: #4 $ $Change: 2912 $ $DateTime: 2002/01/22 01:51:40 $

package Lingua::Sinica::PerlYuYan;
$Lingua::Sinica::PerlYuYan::VERSION = '0.02';

use strict;
use Filter::Simple 0.70;

=head1 �W

Lingua::Sinica::PerlYuYan - Use Chinese to write Perl

=head1 �K

    #!/usr/local/bin/perl
    # The Sieve of Eratosthenes - �J�Ԧ�����z�k
    use Lingua::Sinica::PerlYuYan;

    ���w�����Y  ���U���Lê�C
    �L��̰��o  �S�D�ƵM�v�C
    �I�_�^�­�  ��p�J�j�X�C
    �ߤ��^�}�a  �äG�ܯ­��C
    ��_�q���  �[�}�a�X�l�C
    �}�a��z�l  ôô�����q�C
    �װ}�a���L  ���D���Ыv�C
    ��ű��q�I  �C�׵����ӡC

=head1 ��

The B<Lingua::Sinica::PerlYuYan> makes it makes it possible to write
Perl programs in Chinese. (If you have to ask "Why?", please refer to
L<Lingua::Romana::Perligata> for related information.)

This module uses the single-character property of Chinese to disambiguate
between keywords, thus whitespaces could be omitted this way, much like
in real Chinese writings.

The vocabulary is of the I<WenYanWen> (�娥��, literary text) mode, not
much used in modern Chinese, which prefers the I<BaiHuaWen> (�ոܤ�, spoken
text) mode with multiple-syllable words.

You could use C<Lingua::Sinica::PerlYuYan::translate()> (or simply
as C<Ķ()>) to translate a string containing English programs into
Chinese.

=head1 ��

Currently Big-5 only. UTF8 and GB2312 support is trivial, and will be
available upon request.

=cut

our %Tab;
while (<DATA>) {
    chomp; my $chi = <DATA>; chomp $chi;
    $chi =~ s/[\s\t]//g;
    @Tab{$chi =~ /(..)/g} = map { /^[a-z]/ ? "$_ " : $_ } split(/[\s\t]/, $_);
}

@Tab{qw/���     �ä�    �ɤ�     �C��     �M��/} = qw{
    __DATA__ __END__ __FILE__ __LINE__ __PACKAGE__
};

FILTER {
    foreach my $key (sort {length $b cmp length $a} keys %Tab) {
	s/\Q$key\E/$Tab{$key}/g;
    }

    return $_;
};

sub translate {
    my $code = shift;

    foreach my $key (sort {length $Tab{$b} cmp length $Tab{$a}} keys %Tab) {
	$code =~ s/\Q$Tab{$key}\E/$key/g;
    }

    return $code;
}

1;

=head1 ��

L<Filter::Simple>, L<Lingua::Romana::Perligata>.

=head1 �@

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 �v

Copyright 2001 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

__DATA__
a b c d e f g h i j k l m n o p q r s t u v w x y z
�ҤA���B���v�����ЬѤl���G�f���x�ȥ��Ө�����a������
0 1 2 3 4 5 6 7 8 9 10
�s�@�G�T�|�����C�K�E�Q
! @ # # $ % % ^ & * ( ) - = _ + + [ ] { } \ | ; : : 
�D�}���������ҪR�M���_�X��ᩳ�[�����~�l�װ��p���M��
' ' " " , , => < . . > / / ? ` ` ~
��o�D�v�S�ûP �p�I���j�����j���ô
0 1 2 3 4 5 6 7 8 9
��������������������
! @ # $ % ^ & * ( ) - = _ + [ ] { } \ | ; ; : ' " , , < . > / ? ` ~
�I�I���C�H�s�����]�^�Сסšϡe�f�a�b���U�F�C�G�����A�B�աD�֢��H����
.. ... ** ++ -- abs atan2 sin cos int log sqrt rand srand
�� �D  �� �W �� ��  ��    ��  �l  ��  ��  ��   ��   ��
== && || and or lt gt cmp eq not
�� �� �\ �B  �� �e �� ��  �P �_
q/ qq/ m/ s/ tr/
�� ��  �� �N �� 
chomp chop chr hex oct ord lc lcfirst uc ucfirst quotemeta
�I    ��   ��  ��  ��  ��  �� ��      �� �p      �h
crypt length pos pack unpack split study index join substr
�K    ��     ��  �]   ��     ��    ��    ��    ��   ��
defined undef scalar reset pop push shift unshift splice grep map sort
�w      ��    �q     ��    �u  ��   ��    ��      ��     �z   �M  ��
reverse delete each exists keys values
�f      �R     �C   �s     ��   ��
open close eof read getc readline print printf sprintf write pipe tell seek
�}   ��    ��  Ū   �^   ��       �L    ��     �s      �g   ��   �i   �j
STDIN STDOUT STDERR
�J    �X     �~
do sub eval exit for foreach goto return if unless until while wantarray
�� ��  ��   ��   ��  �v      �D   �^     �Y �L     ��    ��    ��
last next redo continue die warn croak carp
��   ��   ��   ��       ��  �T   �`    �D
BEGIN END INIT CHECK DESTROY
��    ��  �|   ��    ��
-> :: bless caller package ref tie tied untie require use
�� �v ��    ��     �M      ��  ��  ��   ��    ��      ��
chdir chmod chown fcntl flock glob ioctl link unlink mkdir
��    �v    ��    ��    ��    ��   ��    ��   �P     �y
rename rmdir stat truncate alarm dump
��     ��    �A   �Y       �a    ��
exec fork kill sleep system umask wait
��   ��   ��   �v    �@     �X    ��
attributes autouse base blib bytes charnames constant diagnostics encoding fields
��         ��      ��   �A   �r    �W        �`       �E          �X       ��
filetest integer less locale overload sigtrap strict subs utf8 vars vmsish warnings
��       �w      ��   ��     ��       ��      �Y     ��   �q   ��   ��     ĵ
Lingua::Sinica::PerlYuYan::translate
Ķ
$/ $_ @_ "\x20" "\t" "\n" local my our main
�q �� �� ��     ��   �C   ��    �^ ��  �D

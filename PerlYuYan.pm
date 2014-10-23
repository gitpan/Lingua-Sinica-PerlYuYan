# $File: //member/autrijus/Lingua-Sinica-PerlYuYan/PerlYuYan.pm $ $Author: autrijus $
# $Revision: #2 $ $Change: 706 $ $DateTime: 2002/08/18 03:49:00 $

package Lingua::Sinica::PerlYuYan;
$Lingua::Sinica::PerlYuYan::VERSION = '0.03';

use strict;
use Filter::Simple 0.70;

=head1 NAME

Lingua::Sinica::PerlYuYan - Use Chinese to write Perl

=head1 SYNOPSIS

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

=head1 DESCRIPTION

The B<Lingua::Sinica::PerlYuYan> makes it makes it possible to write
Perl programs in Chinese. (If you have to ask "Why?", please refer to
L<Lingua::Romana::Perligata> for related information.)

This module uses the single-character property of Chinese to disambiguate
between keywords, thus whitespaces could be omitted this way, much like
in real Chinese writings.

The vocabulary is of the I<WenYanWen> (�娥��, literary text) mode,
not much used in modern Chinese, which prefers the I<BaiHuaWen>
(�ոܤ�, spoken text) mode with multiple-syllable words.

You could use C<Lingua::Sinica::PerlYuYan::translate()> (or simply
as C<Ķ()>) to translate a string containing English programs into
Chinese.

=head1 CAVEATS

Currently Big-5 only. UTF-8 and GB2312 support is trivial, and will be
available upon request.

=cut

our %Tab;
while (<DATA>) {
    next if /^\s*$/;
    chomp; my $chi = <DATA>; chomp $chi;
    $chi =~ s/\w\w+//g;
    $chi =~ s/\s//g;
    @Tab{$chi =~ /(..)/g} = map { /^[a-z]+$/ ? "$_ " : $_ } split(/[\s\t]/, $_);
}

@Tab{qw/���     �ä�    �ɤ�     �C��     �M��/} = qw{
        __DATA__ __END__ __FILE__ __LINE__ __PACKAGE__
};

FILTER {
    foreach my $key (sort {length $b <=> length $a} keys %Tab) {
	print "$key\n";
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

=head1 SEE ALSO

L<Filter::Simple>, L<Lingua::Romana::Perligata>.

=head1 AUTHORS

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 COPYRIGHT

Copyright 2001, 2002 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

__DATA__
a b c d e f g h i j k l m n o p q r s t u v w x y z
�ҤA���B���v�����ЬѤl���G�f���x�ȥ��Ө�����a������
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
�C�ߨ��x���ʥժͶµǹ�������s�D���ϵU�����ެK�L��V

0 1 2 3 4 5 6 7 8 9 10 100 1000 10000 10000_0000
�s�@�G�T�|�����C�K�E�Q ��  �d   �U    ��
0 1 2 3 4 5 6 7 8 9 10 100 1000 20 30
�s���L���v��m�èh�B ��  �a   �� ��
0 1 2 3 4 5 6 7 8 9
��������������������

! @ # # $ % % ^ & * ( ) - = _ + + [ ] { } \ | ; : : 
�D�}���������ҪR�M���_�X��ᩳ�[�����~�l�װ��p���M��
' ' " " , , => < . . > / / ? ` ` ~
��o�D�v�S�ûP �p�I���j�����j���ô
! @ # $ % ^ & * ( ) - = _ + [ ] { } \ | ; ; : ' " , , < . > / ? ` ~
�I�I���C�H�s�����]�^�Сסšϡe�f�a�b���U�F�C�G�����A�B�աD�֢��H����

.. ... ** ++ -- -> ::
�� �D  �� �W �� �� �v

&& == || and or lt gt cmp eq not
�� �� �\ �B  �� �e �� ��  �P �_

$/ $_ @_ "\x20" "\t" "\n" main
�q �� �� ��     ��   �C   �D

STDIN STDOUT STDERR DATA BEGIN END INIT CHECK DESTROY
�J    �X     �~     ��   ��    ��  �|   ��    ��

chomp chop chr crypt hex index lc lcfirst length oct ord pack q/ qq/ reverse
�I    ��   ��  �K    ��  ��    �� ��      ��     ��  ��  �]   �� ��  �f      
rindex sprintf substr tr/ uc ucfirst y/
��     �s      ��     ��  �� �p      �� 

m/ pos quotemeta s/ split study qr/
�� ��  �h        �N ��    ��    �W

abs atan2 cos exp hex int log oct rand sin sqrt srand
��  ��    �l  ��  ��  ��  ��  ��  ��   ��  ��   ��    

pop push shift splice unshift
�u  ��   ��    ��     ��      

grep join map qw/ reverse sort unpack
�z   ��   �M  �g  �f      ��   ��     

delete each exists keys values
�R     �C   �s     ��   ��     

binmode close closedir dbmclose dbmopen die eof fileno flock format getc
�k      ��    ��       ��       ��      ��  ��  ��     ��    ��     �^
print printf read readdir rewinddir seek seekdir select syscall
�L    ��     Ū   readdir rewinddir �j   seekdir ��     ��
sysread sysseek syswrite tell telldir truncate warn write
sysread sysseek syswrite �i   telldir �Y       �T   �g

pack read syscall sysread syswrite unpack vec
�]   Ū   syscall sysread syswrite ��     �V 

chdir chmod chown chroot fcntl glob ioctl link lstat mkdir open opendir
��    �v    ��    �E     ��    ��   ��    ��   lstat �y    �}   opendir 
readlink rename rmdir stat symlink umask unlink utime
readlink ��     ��    �A   symlink �X    �P     utime 

caller continue die do dump eval exit goto last next redo return sub wantarray
��     ��       ��  �� ��   ��   ��   �D   ��   ��   ��   �^     ��  ��        

caller import local my our package use
��     ��     ��    �^ ��  �M      ��  

defined dump eval formline local my our reset scalar undef wantarray
�w      ��   ��   formline ��    �^ ��  ��    �q     ��    ��        

alarm exec fork getpgrp getppid getpriority kill
�a    ��   ��   getpgrp getppid getpriority ��   

pipe qx/ setpgrp setpriority sleep system times wait waitpid
��   qx/ setpgrp setpriority �v    �@     �p    ��   waitpid 

do no package require use
�� �L �M      ��      ��  

bless dbmclose dbmopen package ref tie tied untie
��    dbmclose dbmopen �M      ��  ��  ��   ��

accept bind connect getpeername getsockname getsockopt listen recv send
��     ��   �s      getpeername getsockname getsockopt ��     ��   �e

setsockopt shutdown sockatmark socket socketpair 
setsockopt shutdown sockatmark ��     socketpair 

msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite
msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite

endgrent endhostent endnetent endpwent getgrent getgrgid getgrnam
endgrent endhostent endnetent endpwent getgrent getgrgid getgrnam

getlogin getpwent getpwnam getpwuid setgrent setpwent 
getlogin getpwent getpwnam getpwuid setgrent setpwent 

endprotoent endservent gethostbyaddr gethostbyname
endprotoent endservent gethostbyaddr gethostbyname 

gethostent getnetbyaddr getnetbyname getnetent
gethostent getnetbyaddr getnetbyname getnetent 

getprotobyname getprotobynumber getprotoent
getprotobyname getprotobynumber getprotoent 

getservbyname getservbyport getservent sethostent
getservbyname getservbyport getservent sethostent 

setnetent setprotoent setservent
setnetent setprotoent setservent 

gmtime localtime time
��     ��        ��

attributes autouse base blib bytes charnames constant diagnostics encoding fields
��         ��      ��   �A   �r    �W        �`       �E          �X       ��
filetest integer less locale overload sigtrap strict subs utf8 vars vmsish warnings
��       �w      ��   ��     ��       ��      �Y     ��   �q   ��   ��     ĵ
Lingua::Sinica::PerlYuYan::translate Lingua::Sinica::PerlYuYan::Tab
Ķ                                   ��

# $File: //member/autrijus/Lingua-Sinica-PerlYuYan/PerlYuYan.pm $ $Author: autrijus $
# $Revision: #4 $ $Change: 2912 $ $DateTime: 2002/01/22 01:51:40 $

package Lingua::Sinica::PerlYuYan;
$Lingua::Sinica::PerlYuYan::VERSION = '0.02';

use strict;
use Filter::Simple 0.70;

=head1 名

Lingua::Sinica::PerlYuYan - Use Chinese to write Perl

=head1 摘

    #!/usr/local/bin/perl
    # The Sieve of Eratosthenes - 埃拉托斯芬篩法
    use Lingua::Sinica::PerlYuYan;

    用籌兮用嚴  井涸兮無礙。
    印曰最高矣  又道數然哉。
    截起吾純風  賦小入大合。
    習予吾陣地  並二至純風。
    當起段賦取  加陣地合始。
    陣地賦篩始  繫繫此雜段。
    終陣地兮印  正道次標哉。
    輸空接段點  列終註泰來。

=head1 介

The B<Lingua::Sinica::PerlYuYan> makes it makes it possible to write
Perl programs in Chinese. (If you have to ask "Why?", please refer to
L<Lingua::Romana::Perligata> for related information.)

This module uses the single-character property of Chinese to disambiguate
between keywords, thus whitespaces could be omitted this way, much like
in real Chinese writings.

The vocabulary is of the I<WenYanWen> (文言文, literary text) mode, not
much used in modern Chinese, which prefers the I<BaiHuaWen> (白話文, spoken
text) mode with multiple-syllable words.

You could use C<Lingua::Sinica::PerlYuYan::translate()> (or simply
as C<譯()>) to translate a string containing English programs into
Chinese.

=head1 瑕

Currently Big-5 only. UTF8 and GB2312 support is trivial, and will be
available upon request.

=cut

our %Tab;
while (<DATA>) {
    chomp; my $chi = <DATA>; chomp $chi;
    $chi =~ s/[\s\t]//g;
    @Tab{$chi =~ /(..)/g} = map { /^[a-z]/ ? "$_ " : $_ } split(/[\s\t]/, $_);
}

@Tab{qw/資曰     亂曰    檔曰     列曰     套曰/} = qw{
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

=head1 見

L<Filter::Simple>, L<Lingua::Romana::Perligata>.

=head1 作

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 權

Copyright 2001 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

__DATA__
a b c d e f g h i j k l m n o p q r s t u v w x y z
甲乙丙丁戊己庚辛壬癸子丑寅卯辰巳午未申酉戌亥地水火風
0 1 2 3 4 5 6 7 8 9 10
零一二三四五六七八九十
! @ # # $ % % ^ & * ( ) - = _ + + [ ] { } \ | ; : : 
非陣井註純雜模析和乘起合減賦底加正內外始終參聯兮然標
' ' " " , , => < . . > / / ? ` ` ~
曰矣道哉又並與 小點接大除分歟行者繫
0 1 2 3 4 5 6 7 8 9
０１２３４５６７８９
! @ # $ % ^ & * ( ) - = _ + [ ] { } \ | ; ; : ' " , , < . > / ? ` ~
！＠＃＄％︿＆＊（）－＝ˍ＋〔〕｛｝╲｜；。：’”，、＜．＞╱？‵～
.. ... ** ++ -- abs atan2 sin cos int log sqrt rand srand
至 乃  冪 增 扣 絕  角    弦  餘  整  對  根   亂   騷
== && || and or lt gt cmp eq not
等 及 許 且  或 前 後 較  同 否
q/ qq/ m/ s/ tr/
引 雙  符 代 轉 
chomp chop chr hex oct ord lc lcfirst uc ucfirst quotemeta
截    斬   文  爻  卦  序  纖 細      壯 厚      逸
crypt length pos pack unpack split study index join substr
密    長     位  包   啟     切    習    索    併   部
defined undef scalar reset pop push shift unshift splice grep map sort
定      消    量     抹    彈  推   取    予      抽     篩   映  排
reverse delete each exists keys values
逆      刪     每   存     鍵   值
open close eof read getc readline print printf sprintf write pipe tell seek
開   閉    結  讀   擷   覽       印    輸     編      寫   管   告   搜
STDIN STDOUT STDERR
入    出     誤
do sub eval exit for foreach goto return if unless until while wantarray
為 副  執   離   有  逐      躍   回     若 微     期    當    欲
last next redo continue die warn croak carp
尾   次   重   續       死  訊   亡    訴
BEGIN END INIT CHECK DESTROY
創    末  育   察    滅
-> :: bless caller package ref tie tied untie require use
之 宗 祝    喚     套      照  纏  縛   解    必      用
chdir chmod chown fcntl flock glob ioctl link unlink mkdir
目    權    擁    控    鎖    全   制    鏈   鬆     造
rename rmdir stat truncate alarm dump
更     毀    態   縮       鈴    傾
exec fork kill sleep system umask wait
生   殖   殺   眠    作     蒙    候
attributes autouse base blib bytes charnames constant diagnostics encoding fields
性         活      基   括   字    名        常       診          碼       欄
filetest integer less locale overload sigtrap strict subs utf8 vars vmsish warnings
試       籌      少   國     載       號      嚴     式   通   變   倭     警
Lingua::Sinica::PerlYuYan::translate
譯
$/ $_ @_ "\x20" "\t" "\n" local my our main
段 此 諸 空     格   列   域    吾 咱  主

package Date::Holidays::KR;
use strict;
use warnings;
use Carp;
use base 'Exporter';
use Date::Korean;
our $VERSION = '0.01';

our @EXPORT = qw/is_holiday holidays/;
our @EXPORT_OK = qw/is_solar_holiday is_lunar_holiday/;

my $SOLAR = {
	'0101' => '신정',
	'0301' => '삼일절',
	'0505' => '어린이날',
	'0606' => '현충일',
	'0815' => '광복절',
	'1003' => '개천절',
	'1225' => '크리스마스',	
};

my $LUNAR = {
	'1229' => '설앞날',
	'0101' => '설날',
	'0102' => '설뒷날',
	'0408' => '부처님오신날',
    '0814' => '추석앞날',
    '0815' => '추석',
    '0816' => '추석뒷날',
};

sub is_solar_holiday {
    my ($year, $month, $day) = @_;
    defined $year  || return;
    defined $month || return;
    defined $day   || return;
    return $SOLAR->{sprintf '%02d%02d', $month, $day};
}

sub is_lunar_holiday {
    my ($year, $month, $day) = @_;
    defined $year  || return;
    defined $month || return;
    defined $day   || return; 

    my ($ly, $lm, $ld, $leap) = sol2lun($year, $month, $day);
    return if $leap;
    return $LUNAR->{sprintf '%02d%02d', $lm, $ld};
}

sub is_holiday {
    is_solar_holiday(@_) || is_lunar_holiday(@_);
}

sub holidays {
    my ($year) = @_;
    defined $year || return;

    my $holidays = { %{ $SOLAR } };

    for my $date (%{ $LUNAR }) {
        my ($lmonth, $lday) = $date =~ /^(\d\d)(\d\d)$/;
        my ($syear, $smonth, $sday) = lun2sol($year, $lmonth, $lday);
        $holidays->{sprintf '%02%02d', $smonth, $sday} = $LUNAR->{$date}; 
    }
    $holidays;
}

1;
__END__

=encoding utf8

=head1 NAME

Date::Holidays::KR - Determine Korean public holidays

=head1 SYNOPSIS

  use Date::Holidays::KR;
  use DateTime;

  my $dt = DateTime->now( time_zone => 'local' );
  if (my $holiday_name = is_holiday($dt->year, $dt->month, $dt->day)) {
  	print "오늘은 $holiday_name 입니다";
  }

=head1 DESCRIPTION

Date::Holidays::KR determines public holidays for Korean. 

=head1 FUNCTION

=over 4

=item is_holiday

takes year, month, date as parameters, and returns the name of the holiday
if it's a holiday, or undef otherwise.

=item holidays

takes a year, and returns a hashref of all the holidays for the year

=back

=head1 CAVEATS

=over 4

=item *

Currently supported data range is from solar 1391-02-05 ( lunisolar 1391-01-01 ) to 2050-12-31 ( lunisolar 2050-11-18 )

=back

=head1 AUTHOR

Jeen Lee E<lt>aiatejin {at} gmail.comE<gt>

=head1 SEE ALSO

L<Date::Korean>, L<Date::Holidays::CN>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

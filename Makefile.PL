use inc::Module::Install;
name 'Date-Holidays-KR';
all_from 'lib/Date/Holidays/KR.pm';
requires 'Date::Korean' => 0;

tests 't/*.t';
test_requires 'Test::More';
resources repository => 'git://github.com/JEEN/p5-Date-Holidays-KR.git';
auto_include;
WriteAll;

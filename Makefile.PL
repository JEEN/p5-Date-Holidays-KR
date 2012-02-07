use inc::Module::Install;
name 'Date-Holidays-KR';
all_from 'lib/Date/Holidays/KR.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;

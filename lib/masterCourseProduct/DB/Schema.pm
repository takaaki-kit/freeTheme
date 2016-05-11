package masterCourseProduct::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'masterCourseProduct::DB::Row';

table {
    name 'user';
    pk 'id';
    columns qw(id user_id name password);
};

table {
    name 'request';
    pk 'id';
    columns qw(id user_id name password);
};
1;

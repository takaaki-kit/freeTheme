use strict;
use warnings;
use Test::More;


use masterCourseProduct;
use masterCourseProduct::Web;
use masterCourseProduct::Web::View;
use masterCourseProduct::Web::ViewFunctions;

use masterCourseProduct::DB::Schema;
use masterCourseProduct::Web::Dispatcher;


pass "All modules can load.";

done_testing;

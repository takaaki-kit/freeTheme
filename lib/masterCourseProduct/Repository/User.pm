package masterCourseProduct::Repository::User;
use strict;
use warnings;
use utf8;
use masterCourseProduct;
use DDP;

sub db {masterCourseProduct->context->db}

my $user_id;
my $user_name;
my $user_password;

sub regist_user{
    my ($class, $regist_user) = @_;
    my $id = $regist_user->[0];
    my $name = $regist_user->[1];
    my $password = $regist_user->[2];

    $class->db->fast_insert(user =>{
        user_id     =>  $id,
        name        =>  $name,
        password    =>  $password
    });

    my $row = $class->db->search_by_sql(q{SELECT id,name FROM user},[1],'user');

    p $row;
};

1;

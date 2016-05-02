package masterCourseProduct::Repository::User;
use strict;
use warnings;
use utf8;
use masterCourseProduct;
use DDP;

sub db {masterCourseProduct->context->db}

sub regist_user{
    my ($class, $regist_user) = @_;
    my $id = $regist_user->[0];
    my $name = $regist_user->[1];
    my $password = $regist_user->[2];

    my $result = $class->db->search('user',{},{order_by => 'id'});
    my @all = $result->all;
    my $str="already regist";
    p $id;
    foreach my $element(@all){
        if($element->{row_data}->{user_id} eq $id){
            p $str;
            return 0;
        }
    }

    $class->db->fast_insert(user =>{
        user_id     =>  $id,
        name        =>  $name,
        password    =>  $password
    });
    return 1;
};

1;

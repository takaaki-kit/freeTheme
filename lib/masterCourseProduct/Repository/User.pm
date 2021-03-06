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
    foreach my $element(@all){
        if($element->{row_data}->{user_id} eq $id){
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

sub login_user{
    my ($class,$login_user) = @_;
    my $id = $login_user->[0];
    my $password = $login_user->[1];

    my $result = $class->db->single('user',{user_id => $id,password =>$password},{});
    if(defined $result){return 0;}
    return 1;

};

sub regist_request{
    my ($class,$params) = @_;
    my $inviter = $params->[0];
    my $invitee = $params->[1];
    my $purpose = $params->[2];
    my $estimated_time = $params->[3];

    $class->db->fast_insert(request =>{
        inviter         => $inviter,
        invitee         => $invitee,
        purpose         => $purpose,
        estimated_time  =>$estimated_time
    });

    return 1;
};

1;

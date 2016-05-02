package masterCourseProduct::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use masterCourseProduct::Repository::User;
use DDP;

get '/' =>sub{
    my ($c,$args) = @_;

    return $c->render('login.tx',{
        action          =>  '/', 
        submit_button   =>  'register',
    });
};

post '/' => sub{
    my($c,$args) = @_;
    my $regist_user_id = $c->req->parameters->{id};
    my $regist_user_name = $c->req->parameters->{name};
    my $regist_user_password = $c->req->parameters->{password}; 
    my @regist_user = ($regist_user_id,$regist_user_name,$regist_user_password);

    
    if($regist_user_id eq ''){p @regist_user;}
    if($regist_user_name eq ''){print("not name");}
    if($regist_user_password eq ''){print("not password");}
    
    my $str="ababa";
    my $isAlreadyRegist = masterCourseProduct::Repository::User->regist_user(\@regist_user);
    p $isAlreadyRegist;
    if($isAlreadyRegist==0){p $str;}
    return $c->redirect('/mainpage');
};

get '/mainpage' =>sub{
    my($c,$args) = @_;

    return $c->render('mainpage.tx',{

    });
};

1;

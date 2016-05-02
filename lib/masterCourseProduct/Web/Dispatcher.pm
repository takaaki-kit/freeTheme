package masterCourseProduct::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use masterCourseProduct::Repository::User;
use DDP;

get '/' =>sub{
    my ($c,$args) = @_;

    return $c->render('signin.tx',{
        action_signin           =>  '/signin', 
        action_login            =>  '/login', 
        submit_button_signin    =>  'register',
        submit_button_login     =>  'login',
    });
};

post '/signin' => sub{
    my $hoge="signin";
    p $hoge;
    my($c,$args) = @_;
    my $regist_user_id = $c->req->parameters->{signin_id};
    my $regist_user_name = $c->req->parameters->{signin_name};
    my $regist_user_password = $c->req->parameters->{signin_password}; 
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

post '/login' => sub{
    my $hoge="login";
    p $hoge;

    my($c,$args) = @_;
    my $login_user_id = $c->req->parameters->{login_id};
    my $login_user_password = $c->req->parameters->{login_password};
    my @login_user = ($login_user_id,$login_user_password);

    my $isExistedUser = masterCourseProduct::Repository::User->login_user(\@login_user);

    return $c->redirect('/mainpage');
};

get '/mainpage' =>sub{
    my($c,$args) = @_;

    return $c->render('mainpage.tx',{

    });
};

1;

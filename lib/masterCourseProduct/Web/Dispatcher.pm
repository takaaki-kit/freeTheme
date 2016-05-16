package masterCourseProduct::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use masterCourseProduct::Repository::User;
use DDP;
use CGI;
use CGI::Session qw/-ip_match/;
use utf8;

#my $path ="/session";
my $path="/Users/takaaki.konaka/dev/engineer2015training/freeTheme/masterCourseProduct/session";


get '/' =>sub{
    my ($c,$args) = @_;

    return $c->render('signin.tx',{
            });
};

post '/signin' => sub{
    my($c,$args) = @_;
    my $regist_user_id = $c->req->parameters->{signin_id};
    my $regist_user_name = $c->req->parameters->{signin_name};
    my $regist_user_password = $c->req->parameters->{signin_password}; 
    my @regist_user = ($regist_user_id,$regist_user_name,$regist_user_password);


    if($regist_user_id eq ''){p @regist_user;}
    if($regist_user_name eq ''){print("not name");}
    if($regist_user_password eq ''){print("not password");}

    my $isAlreadyRegist = masterCourseProduct::Repository::User->regist_user(\@regist_user);
    if($isAlreadyRegist==0){
        return $c->render('signin.tx',{
                error_code  =>  'already existed',
                });
    }
    return $c->redirect('/mainpage');
};

post '/login' => sub{
    my($c,$args) = @_;
    my $login_user_id = $c->req->parameters->{login_id};
    my $login_user_password = $c->req->parameters->{login_password};
    my @login_user = ($login_user_id,$login_user_password);


    my $isExistedUser = masterCourseProduct::Repository::User->login_user(\@login_user);

    if($isExistedUser==0){
        return $c->render('signin.tx',{
                error_code  =>  'ID or PASS is not correct',
                });
    }
#    my $cgi = new CGI;
#    my $sid = $cgi->cookie('CGISESSID') || undef;
#    my $session = new CGI::Session(undef,$sid,{Directory=>$path});
#    my $cookie = $cgi->cookie(-name    => "CGISESSID",
#            -value   => "$session->id",
#            -expires => "+1d");
#    $cookie = &cookie_path_fix($cookie);
#    print $cgi->header( -cookie=>$cookie, -charset=>'Shift_JIS');
#
#    my $readcookie = $cgi->cookie("CGISESSID");
#    p $session->id;
#    p $readcookie;
    return $c->redirect('/mainpage');
};

get '/mainpage' =>sub{
    my($c,$args) = @_;

    my $q = new CGI;


#    my $str1="ok";
#    my $str2="no";
#    my $sid = $q->cookie("CGISESSID") || undef;
#    if($sid)
#    {
#        p $str1;
#        print "session ID is $sid";
#    }else{
#        p $str2;
#        print "no session ID";
#    }

    return $c->render('mainpage.tx',{

            });
};

get '/scheduling' => sub{
    my ($c,$args) = @_;

    return $c->render('scheduling.tx',{
        action  =>  '/scheduling'      
    });
};

post '/scheduling' => sub{
    my($c,$args) = @_;
    
    my $inviter = "hoge";
    my $invitee = $c->req->parameters->{invitee};
    my $purpose = $c->req->parameters->{purpose};
    my $estimated_time = $c->req->parameters->{estimated_time};
    
    my @req_params = ($inviter,$invitee,$purpose,$estimated_time);
    masterCourseProduct::Repository::User->regist_request(\@req_params);
        
    return $c->redirect('/mainpage');
};


post '/change_date' => sub{
    my($c,$args) = @_;
    p $c->req->parameters->{next};
    p $c->req->parameters->{prev};
    return $c->render('scheduling.tx',{
        action  =>  '/scheduling'      
    });
};

#sub cookie_path_fix {
#    my $a = shift;
#    $a =~ s/path\s*=\s*[^;]*;//i;
#    return $a;
#}
1;

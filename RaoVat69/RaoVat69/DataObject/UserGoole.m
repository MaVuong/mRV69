//
//  UserGoole.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/20/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "UserGoole.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface UserGoole()<GPPSignInDelegate>
{
    
}

@end

@implementation UserGoole{
    void (^fnFinish)(NSDictionary *);
    NSString *stremail;
    
}


UserGoole *us_gg;
+(UserGoole*)share{
    if (us_gg==nil) {
        us_gg=[[UserGoole alloc] init];
    }
    return us_gg;
}
-(id)init{
    if (self=[super init]) {
        [self LoadGoogle];
    }
    return self;
}
-(void)LoadGoogle{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.clientID = kClientId;
    //signIn.scopes = @[ kGTLAuthScopePlusLogin,@"profile",kGTLAuthScopePlusUserinfoEmail];
    //signIn.scopes = @[ @"profile" ];
    signIn.homeServerClientID=@"";
    
    signIn.shouldFetchGooglePlusUser=YES;
    signIn.shouldFetchGoogleUserEmail=YES;
    signIn.shouldFetchGoogleUserID =YES;
    
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    signIn.delegate = self;
    
    [signIn trySilentAuthentication];
}
- (void)SignGG:(void(^)(NSDictionary *))FinishLogin {
    fnFinish=FinishLogin;
    if ([[GPPSignIn sharedInstance] authentication]) {
        [self LoginLoadProfile];
    }else{
        [[GPPSignIn sharedInstance] authenticate];
    }
    
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth  error: (NSError *) error {
    if (error) {
        UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
        [alertview show];
        
    }else{
        if ([[GPPSignIn sharedInstance] authentication]) {
            if (fnFinish) {
                stremail=auth.userEmail;
                [self LoginLoadProfile];
            }
        }
    }
}

-(void)LoginLoadProfile{
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,  GTLPlusPerson *person,  NSError *error) {
        if (error) {
            GTMLoggerError(@"Error: %@", error);
        } else {
            if (fnFinish) {
                
                if (stremail==nil&&person.emails.count>0) {
                    GTLPlusPersonEmailsItem *item=person.emails[0];
                    stremail=item.value;
                }
                
                NSDictionary *dictsend=@{@"account":@"google",
                                         @"name":person.displayName?person.displayName:@"",
                                         @"about":person.aboutMe?person.aboutMe:@"",
                                         @"email":stremail?stremail:@"",
                                         @"birthday":person.birthday?person.birthday:@"",
                                         @"photo":person.image.url?[person.image.url stringByReplacingOccurrencesOfString:@"sz=50" withString:@"sz=250"]:@""};
                fnFinish(dictsend);
                fnFinish=nil;
                [self LoginLoadProfile];
            }
            
        }
    }];
}







@end






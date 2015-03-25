//
//  UserFB.m
//  RaoVat
//
//  Created by Sơn Lê Khắc on 3/1/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "UserFB.h"

@implementation UserFB{
    void (^fnFinish)(NSDictionary *);
}
static UserFB *userfb;
+(UserFB*)share{
    if (userfb==nil) {
        userfb=[[UserFB alloc] init];
    }
    return userfb;
}


- (void)FBlogin:(void(^)(NSDictionary *))FinishLogin {
    fnFinish=FinishLogin;
    if (self.session.accessTokenData.accessToken) {
        [self UpdateprofileFB];
    }else{
        if (self.session.state == FBSessionStateCreated) {
            self.session = [[FBSession alloc] initWithPermissions:@[@"publish_actions",@"publish_stream",@"email",@"user_friends",@"user_birthday",@"user_likes",@"user_photos",@"read_friendlists"]];;
        }else{
            if (self.session.accessTokenData.accessToken.length>0) {
                [self performSelectorInBackground:@selector(UpdateprofileFB) withObject:nil];
            }
            return;
        }
        [self.session openWithCompletionHandler:^(FBSession *session, FBSessionState status,NSError *error) {
            FBSession.activeSession = [UserFB share].session;
            [self performSelectorOnMainThread:@selector(UpdateprofileFB) withObject:nil waitUntilDone:YES];
        }];
    }
}
-(void)UpdateprofileFB{
    
    
    
    [FBRequestConnection startWithGraphPath:@"me" completionHandler:^( FBRequestConnection *connection, id result, NSError *error ) {
        [self performSelectorOnMainThread:@selector(UpdateMain:) withObject:result waitUntilDone:YES];
    }];
    
    
}
-(void)UpdateMain:(NSDictionary *)dictx{
    NSString *stremail=[dictx valueForKey:@"email"];
    if (fnFinish!=nil&&stremail.length>5) {
        NSDictionary *dictsend=@{@"account":@"facebook",
                                 @"id":[dictx valueForKey:@"id"],
                                 @"name":[dictx valueForKey:@"name"]?[dictx valueForKey:@"name"]:@"",
                                 @"about":[dictx valueForKey:@"name"]?[dictx valueForKey:@"name"]:@"",
                                 @"email":[dictx valueForKey:@"email"]?[dictx valueForKey:@"email"]:@"",
                                 @"birthday":[dictx valueForKey:@"name"]?[dictx valueForKey:@"name"]:@"",
                                 @"photo":[dictx valueForKey:@"id"]?[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",[dictx valueForKey:@"id"]]:@""};
        fnFinish(dictsend);
        fnFinish=nil;
    }
}
/*
 
 graph.facebook.com/me/friends?limit=25&offset=25?access_token=CAAE4vJOqqgcBAFHxvbOqNlA1FmxbQXwJNxb7peW6n8ErJQb7U80ZAkaQKHmJLEkscUCm1N41yzZBMubCExKi2Ib8vZAZCXtb9bJtPJ3vsfKD0j6GZAPtaL9BhATJLc0rImAht3vBXZAbOCrZCPguAOuwMFEtZBEKFzNSM1To0PcSO1Dcc8JIe9SneoAkZAUtpuvW0JkqUZBw5PkKeBHeebZAgBL
 
 */


@end

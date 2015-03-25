//
//  UserFB.h
//  RaoVat
//
//  Created by Sơn Lê Khắc on 3/1/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
@interface UserFB : NSObject{
    
}
@property (strong, nonatomic) FBSession *session;
+(UserFB*)share;
- (void)FBlogin:(void(^)(NSDictionary *))FinishLogin;
@end

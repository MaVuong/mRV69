//
//  UserGoole.h
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/20/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGoole : NSObject{
    
}
+(UserGoole*)share;
- (void)SignGG:(void(^)(NSDictionary *))FinishLogin;

@end

//
//  NSString+LKSString.m
//  Edu1
//
//  Created by Sơn Lê Khắc on 5/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "NSString+LKSString.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (LKSString)
- (NSString *) lks_md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end

//
//  NSString+LKSData.m
//  Edu1
//
//  Created by Sơn Lê Khắc on 5/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "NSString+LKSData.h"

@implementation NSString (LKSData)

/*
 huong dan convert NSArray to JSON
 
 NSArray *arraytmp=@[@"cho",@"meo",@"ga",@"vit"];
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arraytmp options:NSJSONWritingPrettyPrinted error:nil];
 NSString *strcv = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 
 */



-(NSArray*)lks_jstoArray{
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:  [self dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    if (jsonArray) {
        return jsonArray;
    }else{
        NSLog(@"ERROR:LKSDATA:%@",error.userInfo.description);
        return nil;
    }
}
-(NSDictionary*)lks_jstoDictionary{
    NSError *error;
    NSDictionary *jsondict = [NSJSONSerialization JSONObjectWithData:  [self dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    if (jsondict) {
        return jsondict;
    }else{
        NSLog(@"ERROR:LKSDATA:%@",error.userInfo.description);
        return [NSDictionary dictionary];
    }
}

@end

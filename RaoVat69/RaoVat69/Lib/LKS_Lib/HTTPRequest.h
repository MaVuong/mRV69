//
//  HTTPRequest.h
//  PhimHDOnline
//
//  Created by Sơn Lê Khắc on 8/10/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+LKSData.h"
#import "NSString+LKSString.h"
#define df_RPT_URL @"http://54.148.167.135:8080/ViizServer/api/"


typedef enum {
    default_useragent=0,
    moblile_useragent=1
} UserAngent;




@interface HTTPRequest : NSObject{
    
}
@property(nonatomic,retain)NSString *stridrequest;
@property(nonatomic,assign)int tagrequest;
@property(nonatomic,retain)NSString *strurlconnect;
@property(nonatomic,assign)UserAngent agent;
@property(nonatomic,assign)NSString *strjsonSend;
@property(nonatomic,assign)BOOL isPos;
-(void)RequestData:(void(^)(NSString *))finishload;
+(NSString *)ConvertDictToString:(NSDictionary*)dict_temp;
+(NSString *)ConvertDictionaryToString:(NSMutableDictionary*)dict_temp;
-(void)CanceRequest;
@end


@interface HTTPRequestManager: NSObject{
    
}
@property(nonatomic,retain)NSMutableArray *arraymanager;
-(void)stopRequestWithTag:(int)tag;
-(void)addRequest:(HTTPRequest *)req;
+(HTTPRequestManager*)shareManager;
-(void)stopAllRequest;


@end
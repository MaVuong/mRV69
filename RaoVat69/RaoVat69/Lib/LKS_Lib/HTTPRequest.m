//
//  HTTPRequest.m
//  PhimHDOnline
//
//  Created by Sơn Lê Khắc on 8/10/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import "HTTPRequest.h"


@implementation HTTPRequest{
    void (^fnFinish)(NSString *);
    NSMutableData *dataconnect;
    NSURLConnection *connection;
}
-(id)init{
    self=[super init];
    if (self) {
        self.tagrequest=0;
    }
    return self;
}
-(void)RequestData:(void(^)(NSString *))finishload{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"Error Request" message:@"request must is MainThread" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [alertview show];
        });
        return;
    }
    
    
    fnFinish=finishload;
    if ([self.strurlconnect rangeOfString:@"http://"].location==NSNotFound) {
        self.strurlconnect=[NSString stringWithFormat:@"%@%@",df_RPT_URL,self.strurlconnect];
    }
    NSURL *urldownload=[NSURL URLWithString:self.strurlconnect];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urldownload];
    [request setHTTPMethod:self.isPos?@"POST":@"GET"];
   
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (self.strjsonSend) {
       
        [request setHTTPBody:[self.strjsonSend dataUsingEncoding: NSUTF8StringEncoding]];
    }
   
    
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    if (self.tagrequest==0) {
        self.tagrequest=arc4random();
    }
    [[HTTPRequestManager shareManager] addRequest:self];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    dataconnect=[NSMutableData data];
//    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
//    NSDictionary *dictDataTB=[HTTPResponse allHeaderFields];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    dataconnect=nil;
    NSLog(@"error: %@",error.userInfo);
    fnFinish(@"");
    [[HTTPRequestManager shareManager] stopRequestWithTag:self.tagrequest];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [dataconnect appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if (fnFinish) {
        NSString *strfinish=[[NSString alloc] initWithData:dataconnect encoding:NSUTF8StringEncoding];
        fnFinish(strfinish);
    }
   [[HTTPRequestManager shareManager] stopRequestWithTag:self.tagrequest];
    
}
-(void)CanceRequest{
    [[HTTPRequestManager shareManager] stopRequestWithTag:self.tagrequest];
}
-(void)StopRequest{
    [connection cancel];
    connection=nil;
    
    dataconnect=nil;
    fnFinish=nil;
}
+(NSString *)ConvertDictionaryToString:(NSMutableDictionary*)dict_temp{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict_temp options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strcv = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strcv;
}
+(NSString *)ConvertDictToString:(NSDictionary*)dict_temp{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict_temp options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strcv = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strcv;
}
-(void)dealloc{
    NSLog(@"release connect");
}
@end

@implementation HTTPRequestManager
 HTTPRequestManager *manager;
+(HTTPRequestManager*)shareManager{
    if (manager==nil) {
        manager=[[HTTPRequestManager alloc] init];
    }
    return manager;
}

-(id)init{
    if (self=[super init]) {
        self.arraymanager=[NSMutableArray array];
    }
    return self;
}






-(void)stopAllRequest{
    for (HTTPRequest *req in self.arraymanager) {
        [req StopRequest];
    }
    [self.arraymanager removeAllObjects];
}


-(void)stopRequestWithTag:(int)tag{
    BOOL check=YES;
    while (check) {
        // lay ra vi tri can go bo
        int c=0;
        int vitriremove=-1;
        for (HTTPRequest *req in self.arraymanager) {
            if (req.tagrequest==tag) {
                vitriremove=c;
            }
            c++;
        }
        
        // go bo vi tri can lay
        if (vitriremove>=0) {
            HTTPRequest *req=self.arraymanager[vitriremove];
            [req StopRequest];
            req=nil;
            [self.arraymanager removeObjectAtIndex:vitriremove];
        }else{
            check=NO;
        }
    }
}

-(void)addRequest:(HTTPRequest *)req{
    [self.arraymanager addObject:req];
    
}




@end





































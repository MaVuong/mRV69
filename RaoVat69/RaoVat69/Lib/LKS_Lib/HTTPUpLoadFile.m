//
//  HTTPUpLoadFile.m
//  Nooz
//
//  Created by Sơn Lê Khắc on 3/12/15.
//  Copyright (c) 2015 Lê Khắc Sơn. All rights reserved.
//

#import "HTTPUpLoadFile.h"

@implementation HTTPUpLoadFile{
    void (^fnFinish)(float,BOOL,NSString *);
    NSMutableData *dataconnect;
}


-(void)UploadProgess:(void(^)(float,BOOL,NSString *))pr_vl{
    fnFinish=pr_vl;
    
  
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:self.strurlupload]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    if (self.truonghopdacbiet) {
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"comment_audiofile\"; filename=\"newarticle.caf\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }else{
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"audiofile\"; filename=\"comment.caf\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
 
    [body appendData:[@"Content-Type:audio/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:self.myDataSend]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    
    
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    dataconnect=[NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error: %@",error.userInfo);
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [dataconnect appendData:data];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    float tb=totalBytesWritten;
    float toltal=totalBytesExpectedToWrite;
    float progress = tb / toltal;
    if (fnFinish) {
        NSString *strMB=[NSString stringWithFormat:@"%.2f/%.2f Mb",tb/(1024*1024),toltal/(1024*1024)];
        fnFinish(progress,NO,strMB);
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *strfinish=[[NSString alloc] initWithData:dataconnect encoding:NSUTF8StringEncoding];
    if (fnFinish) {
        fnFinish(1,YES,strfinish);
        fnFinish=nil;
    }
    
}

-(void)dealloc{
    NSLog(@"dealloc upload content");
}









@end


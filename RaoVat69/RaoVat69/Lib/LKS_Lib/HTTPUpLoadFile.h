//
//  HTTPUpLoadFile.h
//  Nooz
//
//  Created by Sơn Lê Khắc on 3/12/15.
//  Copyright (c) 2015 Lê Khắc Sơn. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HTTPUpLoadFile : NSObject{
    
}
/** do lão đức bảo thủ, đặt biến vô tội vạ, đặt xong không sửa nên mới phải như thế này */
@property(nonatomic,assign)BOOL truonghopdacbiet;
@property(nonatomic,retain)NSString *strurlupload;
@property(nonatomic,retain)NSString *strfileinfo;
@property(nonatomic,retain)NSData *myDataSend;
-(void)UploadProgess:(void(^)(float,BOOL,NSString *))pr_vl;
@end

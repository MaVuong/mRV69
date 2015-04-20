//
//  DTXQController.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 4/20/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "DTXQController.h"
#import "MWPhotoBrowser.h"
#import "SDImageCache.h"
#import "MWCommon.h"
#import "SVViewController.h"
#import "UIImageView+WebCache.h"
@protocol TapDelegate <NSObject>

-(void)TapSelect:(id)sender;

@end

@interface IMGView : UIView{
    
}
@property(nonatomic,retain)id <TapDelegate> ctdelegate;
-(void)SetImageURL:(NSString *)strimg;


@end

@implementation IMGView{
    
}
-(void)SetImageURL:(NSString *)strimg{
    UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:imgview];
    imgview.alpha=0;
    CGAffineTransform tr = CGAffineTransformScale(imgview.transform, 0.5, 0.5);
    imgview.transform = tr;

    [imgview sd_setImageWithURL:[NSURL URLWithString:strimg] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.80];
        imgview.alpha=1.0f;
        CGAffineTransform tr = CGAffineTransformScale(imgview.transform, 2, 2);
        imgview.transform = tr;
        [UIView commitAnimations];
    }];
    [self sendSubviewToBack:imgview];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.ctdelegate TapSelect:self];
}




@end






@interface DTXQController ()

@end

@implementation DTXQController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UILoad];
   
}
-(void)UILoad{
    self.view.backgroundColor=[UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1];
    
    UIView *headerview = [[[NSBundle mainBundle] loadNibNamed:@"DTXQHeader" owner:self options:nil] objectAtIndex:0];
    {
        NSArray *allchild=headerview .subviews;
        for (id child_item in allchild) {
            if ([NSStringFromClass([child_item class]) isEqualToString:@"UIButton"]) {
                UIButton *bt=child_item;
                bt.backgroundColor=[UIColor clearColor];
                [bt addTarget:self action:@selector(ActionClick:) forControlEvents:UIControlEventTouchUpInside];
            }
           
        }
    }
    //[self.view addSubview:headerview];
    
    
    UIView *viewimg=[[[NSBundle mainBundle] loadNibNamed:@"IMGView3" owner:self options:nil] objectAtIndex:0];
    {
        NSArray *allchild=viewimg .subviews;
        NSArray *arrayData=@[@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg",
                             @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg",
                             @"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg",
                             @"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"];
        int cpos=0;
        for (id child_item in allchild) {
            IMGView *imgview=child_item;
            imgview.ctdelegate=(id)self;
            [imgview SetImageURL:arrayData[cpos]];
            cpos++;
            NSLog(@"child_item: %@",NSStringFromClass([child_item class]));
        }
    }
    UIView *contentview=[[[NSBundle mainBundle] loadNibNamed:@"ContentDetail" owner:self options:nil] objectAtIndex:0];
    viewimg.center=ccp(contentview.frame.size.width/2, viewimg.frame.size.height/2+5);
    [contentview addSubview:viewimg];
    {
        UILabel *lbtxt=(id)[contentview viewWithTag:44];
        float ypos=viewimg.frame.origin.y+viewimg.frame.size.height+5;
        NSString *strlbtxt=@"Samsung Galaxy S6Samsung Galaxy S6Trước đó, những đối thủ cùng tầm của Samsung Galaxy S6 và S6 Edge là iPhone 6 và iPhone 6 Plus cũng được nhà phân phối FPT điều chỉnh giảm mỗi model 800.000đ. Giá iPhone 6 16 GB hiện được nhiều nhà bán lẻ lớn như thegioididong.com niêm yết mức 16.990.000đ, iPhone 6 Plus 16 GB giá 19.590.000đ. Trong khi đó, những nhà bán lẻ nhỏ như Hnammobile niêm yết giá thấp hơn, 16.590.000đ cho iPhone 16 GB và 19.190.000đ";
        lbtxt.text=strlbtxt;
        [lbtxt sizeToFit];
        CGRect frmlb=lbtxt.frame;
        frmlb.origin.y=ypos;
        lbtxt.frame=frmlb;
        
        CGRect frmctv=contentview.frame;
        frmctv.size.height=lbtxt.frame.origin.y+lbtxt.frame.size.height+10;
        contentview.frame=frmctv;
        
    }
    
    
    
    float hh=self.view.frame.size.height;
    float ypos=0;
    UIScrollView *scview=[[UIScrollView alloc] initWithFrame:CGRectMake(0,ypos, 320, hh-ypos)];
    
    headerview.center=ccp(headerview.frame.size.width/2, headerview.frame.size.height/2);
    [scview addSubview:headerview];
    
    contentview.center=ccp(160, contentview.frame.size.height/2 +headerview.frame.size.height+headerview.frame.origin.y);
    
    [scview addSubview:contentview];
    
    scview.contentSize=CGSizeMake(320, contentview.frame.size.height+contentview.frame.origin.y);
    [self.view addSubview:scview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)TapSelect:(id)sender{
   
    IMGView *imgview=sender;
    NSLog(@"imgview: %d",imgview.tag);
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    
    {
        
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"]]];
        // Thumbs
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_q.jpg"]]];
    }
    self.photos = photos;
    self.thumbs = thumbs;
    
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:(id)self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:0];
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
    
    
    // Test reloading of data after delay
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
    });
    
}




#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}














#pragma mark ---Button Action

-(void)ActionClick:(id)sender{
    UIButton *bt=sender;
    NSLog(@"bt: %d",bt.tag);
    if (bt.tag==21) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Liên Hệ"
                                              message:@""
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Đóng"style:UIAlertActionStyleCancel
                                       handler:nil];
        
        UIAlertAction *callaction = [UIAlertAction
                                   actionWithTitle:@"Gọi Điện"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction *action)
                                   {
                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://094711682"]];
                                   }];
        UIAlertAction *smsAction = [UIAlertAction
                                     actionWithTitle:@"Tin Nhắn(SMS)"
                                     style:UIAlertActionStyleDestructive
                                     handler:^(UIAlertAction *action)
                                     {
                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://094711682"]];
                                     }];
        
        [alertController addAction:callaction];
        [alertController addAction:smsAction];
        [alertController addAction:cancelAction];
        
        [appdelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    }
    if (bt.tag==23) {
        SVViewController *svview=[[SVViewController alloc] init];
        UINavigationController *navcontroller=[[UINavigationController alloc] initWithRootViewController:svview];
        [appdelegate.window.rootViewController presentViewController:navcontroller animated:YES completion:nil];
    }
    if (bt.tag==20||bt.tag==22) {
        UIViewController *svview=[[UIViewController alloc] init];
        svview.view.backgroundColor=[UIColor whiteColor];
        svview.title=bt.tag==20?@"Shop":@"Chuyen Muc Thoi Trang";
        [self.navigationController pushViewController:svview animated:YES];
    }
    
    
}





@end

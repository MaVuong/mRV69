//
//  LKSNAV.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/25/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "LKSNAV.h"

@interface LKSNAV ()

@end

@implementation LKSNAV

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],NSForegroundColorAttributeName ,nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    self.navigationBar.tintColor = [UIColor colorWithRed:0.9
                                                   green:0.9
                                                    blue:0.9
                                                   alpha:1.0f];
    // Do any additional setup after loading the view.
    
    UIColor *tintColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:1];
    tintColor = [UIColor colorWithRed:0.270 green:0.760 blue:0.760 alpha:1];
    self.navigationBar.barTintColor = tintColor;
    
    UIView *viewbg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    viewbg.backgroundColor=[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1];;
     viewbg.backgroundColor=[UIColor colorWithRed:0.170 green:0.660 blue:0.660 alpha:1];;
    viewbg.tag=88;
    [self.view addSubview:viewbg];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

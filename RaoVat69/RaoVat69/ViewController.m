//
//  ViewController.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/20/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)FacebookLogim:(id)sender{
    [[UserFB share] FBlogin:^(NSDictionary *dict){
        NSLog(@"strfinihs: %@",dict);
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        Test *logincontroller = [mainStoryboard instantiateViewControllerWithIdentifier:@"viewdetail"];
        logincontroller.dict=dict;
        [self.navigationController pushViewController:logincontroller animated:YES];
    }];
}


-(IBAction)GoogleLogin:(id)sender{
    [[UserGoole share] SignGG:^(NSDictionary *dict){
        NSLog(@"dict: %@",dict);
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        Test *logincontroller = [mainStoryboard instantiateViewControllerWithIdentifier:@"viewdetail"];
        logincontroller.dict=dict;
        [self.navigationController pushViewController:logincontroller animated:YES];
    }];
   
    
}

@end

//
//  TKController.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/25/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "TKController.h"
#import "Test.h"
@interface TKController ()

@end

@implementation TKController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Tài Khoản";
    
    UIView *viewft=[[NSBundle mainBundle] loadNibNamed:@"LoginRequest" owner:self options:nil][0];
    self.tableView.tableFooterView=viewft;
    UIButton *bt1=viewft.subviews[0];
    [bt1 addTarget:self action:@selector(FacebookLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bt2=viewft.subviews[1];
    [bt2 addTarget:self action:@selector(GoogleLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)FacebookLogin:(id)sender{
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

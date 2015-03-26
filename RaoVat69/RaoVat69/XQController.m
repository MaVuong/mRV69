//
//  XQController.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/25/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "XQController.h"

@interface XQController ()

@end

@implementation XQController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Xung Quanh";
    [self SetUpUI];
}

-(void)SetUpUI{
    self.tableView.backgroundColor=[UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    
    
    UILabel *lbinfo=(UILabel*)[[cell viewWithTag:100] viewWithTag:2];
    UILabel *lbcost=(UILabel*)[[cell viewWithTag:100] viewWithTag:3];
    {
        int fontsize=13;
        NSString *strtime=@[@"12 phút trước bởi",@"1 tháng trước bởi",@"2 tuần trước bởi",@"5 phút trước bởi",@"15 giờ trước bởi",@"2 ngày trước bởi"][arc4random()%6];
        
        NSString *strname=@[@"sonlk",@"Tieu Long Nu",@"Duong Qua",@"Dam Cong Tu" ][arc4random()%4];
        
        NSString *strText=[NSString stringWithFormat:@"%@ %@",strtime,strname];
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strText];
        [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontsize] range:NSMakeRange(0, strtime.length)];
        [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, strtime.length)];
        [hogan addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontsize] range:NSMakeRange(strtime.length+1, strname.length)];
        lbinfo.attributedText=hogan;
    }
    
    {
        int fontsize=13;
        NSString *strcost=@[@"2 tỉ",@"400.000",@"25 triệu",@"27,5 triệu",@"800.000"][arc4random()%4];
        strcost=[NSString stringWithFormat:@" %@ ",strcost];
        NSString *strdistance=@[@"200 m",@"400m",@"12.5 km",@"120km",@"Toàn Quốc"][arc4random()%4];
        strdistance=[NSString stringWithFormat:@" %@ ",strdistance];
        NSString *strCategory=@[@"Đồ Công Nghệ",@"Thời Trang",@"Nhà Đất",@"Điện Tử",@"Nội Thất"][arc4random()%4];
        strCategory=[NSString stringWithFormat:@" %@ ",strCategory];
        NSString *strText=[NSString stringWithFormat:@"%@ %@ %@",strcost,strdistance,strCategory];
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strText];
        [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontsize] range:NSMakeRange(0, strText.length)];
        
        [hogan addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithRed:0.270 green:0.760 blue:0.760 alpha:1] range:NSMakeRange(0, strcost.length)];
        [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, strcost.length)];
        
        [hogan addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithRed:1.0 green:0.478 blue:0.219 alpha:1] range:NSMakeRange(strcost.length+1, strdistance.length)];
        [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(strcost.length+1, strdistance.length)];
        
        [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.427 green:0.427 blue:0.427 alpha:1] range:NSMakeRange(strcost.length+2+strdistance.length, strCategory.length)];
        [hogan addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1] range:NSMakeRange(strcost.length+2+strdistance.length, strCategory.length)];
        
        lbcost.attributedText=hogan;
    }

    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
@end

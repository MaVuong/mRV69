//
//  RootTabbar.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/25/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "RootTabbar.h"











@interface RootTabbar ()

@end

@implementation RootTabbar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed=YES;
    [self SetUpUI];
}


-(void)SetUpUI{
    UIView *ftview = [[[NSBundle mainBundle] loadNibNamed:@"Tabbar" owner:self options:nil] objectAtIndex:0];
    CGRect frm=self.view.frame;
    ftview.tag=888;
    ftview.center=ccp(frm.size.width/2, frm.size.height-ftview.frame.size.height/2.0f);
    [self.view addSubview:ftview];
    
    NSArray *arraychild=ftview.subviews;
    for (UIButton *bt in arraychild) {
        NSString *str_s=[NSString stringWithFormat:@"bar%d_s",(int)bt.tag];
        NSString *str_u=[NSString stringWithFormat:@"bar%d_u",(int)bt.tag];
        UIImage *img=[UIImage imageNamed:str_s];
        if (img==nil) {
            NSLog(@"Fucj");
        }
        [bt addTarget:self action:@selector(ActionItemSelect:) forControlEvents:UIControlEventTouchUpInside];
        [bt setImage:[UIImage imageNamed:str_u] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:str_s] forState:UIControlStateDisabled];
        if (bt.tag==1) {
            bt.enabled=NO;
        }
        
    }
}
-(void)EnableAll{
    NSArray *arraychild=[self.view viewWithTag:888].subviews;
    for (UIButton *bt in arraychild) {
        bt.enabled=YES;
    }
}
-(IBAction)ActionItemSelect:(id)sender{
    UIButton *bt=sender;
    [self EnableAll];
    bt.enabled=NO;
    [self setSelectedIndex:bt.tag-1];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Test.m
//  RaoVat69
//
//  Created by Sơn Lê Khắc on 3/20/15.
//  Copyright (c) 2015 White Fox. All rights reserved.
//

#import "Test.h"
#import "JSImagePickerViewController.h"
#import "UIImageView+WebCache.h"
@implementation Test{
    
    IBOutlet UIImageView *imgview;
    IBOutlet UILabel *lbaccountype;
    IBOutlet UILabel *lbbmail;
    IBOutlet UILabel *lbbane;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [imgview setImageWithURL:[NSURL URLWithString:[self.dict valueForKey:@"photo"]]];
    lbbane.text=[NSString stringWithFormat:@"Name:%@",[self.dict valueForKey:@"name"]];
    lbbmail.text=[NSString stringWithFormat:@"Email: %@",[self.dict valueForKey:@"email"]];
    lbaccountype.text=[NSString stringWithFormat:@"AcountType:%@",[self.dict valueForKey:@"account"]];
    
}

- (IBAction)actionUPloadAvata:(id)sender {
    
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate =(id)self;
    [imagePicker showImagePickerInController:self animated:YES];
}

#pragma mark - JSImagePikcerViewControllerDelegate

- (void)imagePickerDidSelectImage:(UIImage *)image {
    imgview.image = image;
}

@end

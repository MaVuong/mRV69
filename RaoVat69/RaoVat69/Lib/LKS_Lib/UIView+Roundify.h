//
//  UIView+Roundify.h
//  TestPopUp
//
//  Created by Sơn Lê Khắc on 3/19/15.
//  Copyright (c) 2015 Lê Khắc Sơn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Roundify)
-(void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
-(CALayer*)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;


@end

//
//  Config.h
//  ReportTubePro
//
//  Created by Sơn Lê Khắc on 11/30/14.
//  Copyright (c) 2014 Lê Khắc Sơn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


static inline CGPoint ccp( CGFloat x, CGFloat y )
{
    return CGPointMake(x, y);
}

static inline CGFloat ccpDot(const CGPoint v1, const CGPoint v2)
{
    return v1.x*v2.x + v1.y*v2.y;
}
static inline CGFloat ccpLengthSQ(const CGPoint v)
{
    return ccpDot(v, v);
}
static inline CGFloat ccpLength(const CGPoint v)
{
    return sqrtf(ccpLengthSQ(v));
}
static inline CGPoint ccpSub(const CGPoint v1, const CGPoint v2)
{
    return ccp(v1.x - v2.x, v1.y - v2.y);
}


static inline CGFloat ccpDistance(const CGPoint v1, const CGPoint v2)
{
    return ccpLength(ccpSub(v1, v2));
}

static inline CGPoint
ccpMult(const CGPoint v, const CGFloat s)
{
    return ccp(v.x*s, v.y*s);
}

static inline NSString* lks_tmpPath( NSString *spath)
{
    return [NSString stringWithFormat:@"%@/tmp/%@",NSHomeDirectory(),spath];
}



static inline NSString* lks_documentPath( NSString *spath)
{
    return [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),spath];
}



















//
//  FYAnnotation.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/7.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYAnnotation.h"

@implementation FYAnnotation
- (id)initWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude title:(NSString *)title subTitle:(NSString *)subTitle
{
    self = [super init];
    if (self) {
        self.coordinate = (CLLocationCoordinate2D){latitude, longitude};
        self.title = title;
        self.subtitle = subTitle;
    }
    return self;
}
+ (id)annotationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude title:(NSString *)title subTitle:(NSString *)subTitle
{
    return [[FYAnnotation alloc] initWithLatitude:latitude longitude:longitude title:title subTitle:subTitle];
}
@end

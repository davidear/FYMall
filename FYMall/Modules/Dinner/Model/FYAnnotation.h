//
//  FYAnnotation.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/7.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//
//@optional
//
//// Title and subtitle for use by selection UI.
//@property (nonatomic, readonly, copy) NSString *title;
//@property (nonatomic, readonly, copy) NSString *subtitle;
//
//// Called as a result of dragging an annotation view.
//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(10_9, 4_0);
#import <Foundation/Foundation.h>
#import <MAPointAnnotation.h>
@interface FYAnnotation : MAPointAnnotation
@property (assign, nonatomic) CLLocationDegrees latitude;       // 经度值
@property (assign, nonatomic) CLLocationDegrees longitude;      // 经度值

- (id)initWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude title:(NSString *)title subTitle:(NSString *)subTitle;
+ (id)annotationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude title:(NSString *)title subTitle:(NSString *)subTitle;
@end

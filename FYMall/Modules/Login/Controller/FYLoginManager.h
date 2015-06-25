//
//  FYLoginManager.h
//  FYMall
//
//  Created by dai.fengyi on 15/4/21.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"
//#import "ZKJSTCPSessionManager.h"

@interface FYLoginManager : NSObject
@property (weak, nonatomic) UIWindow *window;
//单例
single_interface(FYLoginManager)

- (void)appStart;
- (void)manualLogin:(NSDictionary *)dic object:(id)object;
- (void)autologin;
@end

//
//  FYAccountTool.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/11.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "FYAccount.h"
@interface FYAccountTool : NSObject
single_interface(FYAccountTool)
@property (nonatomic, readonly) FYAccount *account;
- (void)saveAccount:(FYAccount *)account;
@end

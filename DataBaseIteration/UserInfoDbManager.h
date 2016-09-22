//
//  UserInfoDbManager.h
//  DataBaseIteration
//
//  Created by soul on 16/9/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoDbManager : NSObject

+ (void)formattingData;
+ (BOOL)saveUserName:(NSString *)nameString withUserId:(NSString *)userid;

@end

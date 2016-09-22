//
//  DBVersionUDTool.h
//  meou
//
//  Created by soul on 16/9/19.
//  Copyright © 2016年 xxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ResultBlock)(BOOL result);

@interface DBVersionUDTool : NSObject

@property (nonatomic, copy) ResultBlock result;

- (void)userDataBaseVersionUpdataResult:(ResultBlock )resultblock;

@end

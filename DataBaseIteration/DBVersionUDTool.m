//
//  DBVersionUDTool.m
//  meou
//
//  Created by soul on 16/9/19.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "DBVersionUDTool.h"
#import "FMDB.h"

typedef NS_ENUM(NSInteger, XYUserDBVersion) {
    XYUserDBVersionV1,
};

static FMDatabaseQueue *_queue;

@implementation DBVersionUDTool

#pragma mark - fmdbqueue实例化
- (FMDatabaseQueue *)getSharedDatabaseQueue{
    if (!_queue) {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"mineData.sqlite"];
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    
    return _queue;
}

- (void)userDataBaseVersionUpdataResult:(ResultBlock )resultblock
{
    self.result = resultblock;
    //读取工程中plist文件的数据库版本
    NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DBVersionHistory.plist" ofType:nil]];

    //测试，设置默认值
    XYUserDBVersion version = 0;
    
        switch (version) {
            case XYUserDBVersionV1:{
                [self preVToNewV:tempArray[XYUserDBVersionV1][@"userTable"]];
            }
                break;
            default:
                break;
        }

}
- (void)preVToNewV:(NSArray *)array
{
    [[self getSharedDatabaseQueue] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            
            for (int i = 0; i<array.count; i++) {
                [db executeUpdate:array[i]];
            }
            
        }
        @catch (NSException *exception) {
            *rollback = YES;
            self.result(NO);
        }
    }] ;
    
    self.result(YES);
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"databaseVersion"];

    
}

@end

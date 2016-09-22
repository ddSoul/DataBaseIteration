//
//  UserInfoDbManager.m
//  DataBaseIteration
//
//  Created by soul on 16/9/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "UserInfoDbManager.h"
#import "FMDB.h"

static FMDatabaseQueue *_dbqueue;

@implementation UserInfoDbManager

#pragma mark - 配置数据库单聊
+(FMDatabaseQueue *)getSharedDatabaseQueue
{
    if (!_dbqueue) {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"mineData.sqlite"];
        
        _dbqueue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    
    return _dbqueue;
}
// 格式化数据
+ (void)formattingData{
    
    
    [[self getSharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            NSLog(@"minedata打开成功");
            // 创建信息表(指定字段 id idstr dict access_token)
            NSString *sql = @"CREATE TABLE IF NOT EXISTS t_mineData(userId TEXT, nickname TEXT);";
            if ([db executeUpdate:sql]) {
                
                FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM t_mineData"];
                
                while ([resultSet next]) {
                    [resultSet close];
                    
                    return;
                }
                
                
            }else{
                
                NSLog(@"minedata信息表创建失败");
            }
        }else{
            
            NSLog(@"minedata打开失败");
        }
        
        
    }];
    
    
}

+ (BOOL)saveUserName:(NSString *)nameString withUserId:(NSString *)userid
{
    [[self getSharedDatabaseQueue] inDatabase:^(FMDatabase * db) {

        //test 正式工程只要在工程中写最新的操作就可以
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"databaseVersion"] isEqualToString:@"1"]) {
            
            FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM t_mineData WHERE testId == ?;", userid];
            while ([resultSet next]) {
                if([db executeUpdate:@"UPDATE t_mineData SET testname = ? WHERE testId == ?;", nameString, userid]){
                    NSLog(@"updata success");
                };
                return ;
                
            }
            //        // 当这个userId的数据不存在, 创建一条数据
            if ([db executeUpdate:@"INSERT INTO t_mineData (testId,testname) VALUES (?, ?);",userid, nameString]) {
                NSLog(@"insert success");
            }

        }else{
            
            FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM t_mineData WHERE userId == ?;", userid];
            while ([resultSet next]) {
                if([db executeUpdate:@"UPDATE t_mineData SET nickname = ? WHERE userId == ?;", nameString, userid]){
                    NSLog(@"updata success");
                };
                return ;
                
            }
            //        // 当这个userId的数据不存在, 创建一条数据
            if ([db executeUpdate:@"INSERT INTO t_mineData (userId,nickname) VALUES (?, ?);",userid, nameString]) {
                NSLog(@"insert success");
            }

        }

        
    }];

    return YES;
}






@end

//
//  DBManager.h
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "DataManager.h"
#import "DataProtocol.h"
@class FMDatabase;
@interface DBManager : NSObject <DataProtocol> {
  FMDatabase *db;
}
@property(nonatomic, retain) FMDatabase *db;

/*
 @method      getSingle:
 @aSql    查询指定表,无参数查询（例如：select * from 表名），返回查询结果
 @result      NSDictionary *
 */
- (NSDictionary *)getSingle:(NSString *)aSql;

/*
 @method      getList:
 @aSql    查询指定表,无参数查询（例如：select * from 表名），返回查询结果
 @result      NSDictionary *
 */
- (NSMutableArray *)getList:(NSString *)aSql;

/*
 @method      insertWithDictionary
 @abstract    向指定表插入数据
 @parameter   aDic字典里包含一条记录，键是字段名，值是要插入的值
 @result      void
 */
- (void)insertWithTable:(NSString *)tableName Dictionary:(NSDictionary *)aDic;

/*
 @method      deleteWithDictionary: Dictionary:
 @abstract    删除指定表里的数据
 @parameter   aSql删除sql语句，要这样写：delete from tablename where columnname1
 = :columnname1 and(or) ...
 aDic字典里是要删除条件，键是字段名;如果aDic为nil，则删除表里所有的数据
 @result      BOOL
 */
- (BOOL)deleteWithSql:(NSString *)aSql andDictionary:(NSDictionary *)aDic;

/*
 @method      updateWithSql: Dictionary:
 @abstract    更新指定表里的数据
 @parameter   aSql更新sql语句，要这样写：update tablename set columnname1=?,...
 where columnnamen = ? and(or) ...
 aArray数组存储的是和？对应数据
 @result      BOOL
 */
- (BOOL)updateWithSql:(NSString *)aSql andArray:(NSArray *)aArray;
@end

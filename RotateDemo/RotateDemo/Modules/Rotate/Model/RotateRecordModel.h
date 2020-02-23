//
//  RotateRecordModel.h
//  HengtaiStone
//
//  Created by LIHH on 2018/12/18.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RotateRecordModel : NSObject

//** 玩家
@property (nonatomic, copy) NSString *account;
//** 时间
@property (nonatomic, copy) NSString *create_time;
//** 结果
@property (nonatomic, copy) NSString *get_money;
//** 成本
@property (nonatomic, copy) NSString *cost_money;

-(id)initWithDict:(NSDictionary *)dict;



@end

NS_ASSUME_NONNULL_END

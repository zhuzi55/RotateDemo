//
//  RotateRecordModel.m
//  HengtaiStone
//
//  Created by LIHH on 2018/12/18.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import "RotateRecordModel.h"

@implementation RotateRecordModel

-(id)initWithDict:(NSDictionary *)dict{
    if (self =[super init]) {
        
        self.account = @"";
        if (dict[@"account"]) {
            self.account = dict[@"account"];
        }
        
        self.create_time = @"";
        if (dict[@"create_time"]) {
            self.create_time = dict[@"create_time"];
        }
        
        self.get_money = @"";
        if (dict[@"get_money"]) {
            self.get_money = dict[@"get_money"];
        }
        
        self.cost_money = @"";
        if (dict[@"cost_money"]) {
            self.cost_money = dict[@"cost_money"];
        }
        
    }
    return self;
}

@end

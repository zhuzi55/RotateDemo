//
//  RankModel.m
//  HengtaiStone
//
//  Created by LIHH on 2018/9/8.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import "RankModel.h"

@implementation RankModel

-(id)initWithDict:(NSDictionary *)dict{
    if (self =[super init]) {
        
        self.phone = @"";
        if (dict[@"phone"]) {
            self.phone = dict[@"phone"];
        }
        
        self.name = @"";
        if (dict[@"name"]) {
            self.name = dict[@"name"];
        }

        self.get_today = @"";
        if (dict[@"get_today"]) {
            self.get_today = dict[@"get_today"];
        }
        
    }
    return self;
}

@end

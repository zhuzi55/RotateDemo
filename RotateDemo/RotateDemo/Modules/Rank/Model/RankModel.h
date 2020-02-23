//
//  RankModel.h
//  HengtaiStone
//
//  Created by LIHH on 2018/9/8.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

//**手机号
@property (nonatomic, copy) NSString *phone;
//**姓名
@property (nonatomic, copy) NSString *name;
//**进步
@property (nonatomic, copy) NSString *get_today;

-(id)initWithDict:(NSDictionary *)dict;

@end

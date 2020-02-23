//
//  RotateRecordTableViewCell.h
//  HengtaiStone
//
//  Created by LIHH on 2018/12/18.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RotateRecordModel;

NS_ASSUME_NONNULL_BEGIN

@interface RotateRecordTableViewCell : UITableViewCell

//** 赋值
-(void)setDataWithModel:(RotateRecordModel *)model row:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END

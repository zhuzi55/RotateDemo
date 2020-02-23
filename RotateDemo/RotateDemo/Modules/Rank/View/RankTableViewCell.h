//
//  RankTableViewCell.h
//  HengtaiStone
//
//  Created by LIHH on 2018/9/1.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RankModel;

@interface RankTableViewCell : UITableViewCell

-(void)setImageWithName:(NSString *)name;
-(void)setNumWithNumber:(NSString *)number;

-(void)setDataWith:(RankModel *)rankModel;

@end

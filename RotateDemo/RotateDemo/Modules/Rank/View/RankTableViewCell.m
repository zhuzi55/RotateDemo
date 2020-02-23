//
//  RankTableViewCell.m
//  HengtaiStone
//
//  Created by LIHH on 2018/9/1.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import "RankTableViewCell.h"
#import "RankModel.h"

@interface RankTableViewCell()

//** 等级视图或等级lable
@property (nonatomic, strong) UIImageView *rankImageView;
@property (nonatomic, strong) UILabel *rankLable;
//** 姓名标签
@property (nonatomic, strong) UILabel *nameLable;
//** 手机号标签
@property (nonatomic, strong) UILabel *phoneLable;
//** 前进标签
@property (nonatomic, strong) UILabel *advantaceLable;

@end

@implementation RankTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
    
}

-(void)setUI{
    
    //** 等级视图或等级lable
    self.rankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 22, 28)];
    self.rankImageView.image = [UIImage imageNamed:@"rank1"];
    [self.contentView addSubview:self.rankImageView];
    
    self.rankLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 22, 28)];
    self.rankLable.text = @"1";
    self.rankLable.textAlignment = NSTextAlignmentCenter;
    [self.rankLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    self.rankLable.textColor = [UIColor colorWithRed:6/255. green:210/255. blue:221/255. alpha:1];
    [self.contentView addSubview:self.rankLable];
    self.rankLable.hidden = YES;
    
    //** 姓名标签
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.rankImageView.frame)+30, 10, 60, 40)];
    self.nameLable.text = @"张三丰";
//    self.nameLable.textAlignment = NSTextAlignmentCenter;
    [self.nameLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    self.nameLable.textColor = [UIColor colorWithRed:6/255. green:210/255. blue:221/255. alpha:1];
    [self.contentView addSubview:self.nameLable];
    
    //** 手机号标签
    self.phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLable.frame)+10, 10, 150, 40)];
    self.phoneLable.text = @"15517743999";
    [self.phoneLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    self.phoneLable.textColor = [UIColor colorWithRed:6/255. green:210/255. blue:221/255. alpha:1];
    [self.contentView addSubview:self.phoneLable];
    
    //** 前进标签
    self.advantaceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-130, 10, 100, 40)];
    self.advantaceLable.text = @"+99";
    [self.advantaceLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.advantaceLable.textColor = [UIColor colorWithRed:255/255. green:16/255. blue:187/255. alpha:1];
    self.advantaceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.advantaceLable];
    
    //** 横线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.frame.size.width-40, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:24/255. green:47/255. blue:121/255. alpha:1];
    [self.contentView addSubview:lineView];

}

//** 前三名设置图片
-(void)setImageWithName:(NSString *)name{
    self.rankImageView.image = [UIImage imageNamed:name];
    self.rankLable.hidden = YES;
    self.rankImageView.hidden = NO;
}
//** 后面显示数字
-(void)setNumWithNumber:(NSString *)number{
    self.rankLable.text = number;
    self.rankImageView.hidden = YES;
    self.rankLable.hidden = NO;
}

-(void)setDataWith:(RankModel *)rankModel{
    self.nameLable.text = rankModel.name;
    self.phoneLable.text = rankModel.phone;
    self.advantaceLable.text = [NSString stringWithFormat:@"+%@", rankModel.get_today];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  RotateRecordTableViewCell.m
//  HengtaiStone
//
//  Created by LIHH on 2018/12/18.
//  Copyright © 2018年 lyz. All rights reserved.
//

#import "RotateRecordTableViewCell.h"

#import "RotateRecordModel.h"

@interface RotateRecordTableViewCell()

//** 玩家标签
@property(nonatomic, strong) UILabel *playerLable;
//** 时间标签
@property(nonatomic, strong) UILabel *timeLable;
//** 结果标签
@property(nonatomic, strong) UILabel *resultLable;
//** 赠视图
@property (nonatomic, strong) UIImageView *donateImgView;

@end

@implementation RotateRecordTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    return self;
    
}

//** 布局UI
-(void)setUI{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width-20;
    
    //** 玩家标签
    self.playerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w/3, 30)];
    self.playerLable.font = [UIFont systemFontOfSize:12];
    self.playerLable.textColor = [UIColor whiteColor];
    self.playerLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.playerLable];
    
    //** 时间标签
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(w/3, 0, w/3, 30)];
    self.timeLable.font = [UIFont systemFontOfSize:12];
    self.timeLable.textColor = [UIColor whiteColor];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLable];
    
    //** 结果标签
    self.resultLable = [[UILabel alloc] initWithFrame:CGRectMake(w*2/3, 0, w/3, 30)];
    self.resultLable.font = [UIFont systemFontOfSize:12];
    self.resultLable.textColor = [UIColor whiteColor];
    self.resultLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.resultLable];
    
    //** 赠视图
//    self.donateImgView = [[UIImageView alloc] init];
//    self.donateImgView.image = imageNamed(@"rotateDonate");
//    [self.contentView addSubview:self.donateImgView];
//    self.donateImgView.hidden = YES;
    
}

//** 赋值
-(void)setDataWithModel:(RotateRecordModel *)model row:(NSInteger)row{
    
    if (row % 2 == 0) {
        self.backgroundColor = [UIColor colorWithRed:53/255. green:51/255. blue:106/255. alpha:1];
    } else {
        self.backgroundColor = [UIColor colorWithRed:37/255. green:23/255. blue:112/255. alpha:1];
    }
    self.playerLable.text = model.account;
    self.timeLable.text = [self timerIntevalTOFormatterWith:model.create_time];
    self.resultLable.text = [NSString stringWithFormat:@"$%@", model.get_money];
    if ([model.cost_money isEqualToString:@"0"]) {
        self.donateImgView.hidden = NO;
    } else {
        self.donateImgView.hidden = YES;
    }
    
}

//** 时间戳转化为时间
- (NSString *)timerIntevalTOFormatterWith:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.longLongValue];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
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

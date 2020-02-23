//
//  RotateViewController.m
//  RotateDemo
//
//  Created by LIHH on 2020/2/19.
//  Copyright © 2020 lyz. All rights reserved.
//

#import "RotateViewController.h"

#import "SDCycleScrollView.h"
#import "RotateRecordTableViewCell.h"
#import "RotateRecordModel.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface RotateViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate>

//** 大转盘视图
@property (nonatomic, strong) UIImageView *rotateImgView;
//** 奖池金额标签
@property (nonatomic, strong) UILabel *awardValueLable;
//** 开始按钮
@property (nonatomic, strong) UIButton *startButton;
//** 文字轮播图
@property (nonatomic, strong) SDCycleScrollView *titleCycleScrollView;
//** 文字轮播器文字数组
@property (nonatomic, strong) NSArray *titleArray;
//** tableview视图
@property (nonatomic, strong) UITableView *winRecordTableView;
//** 表头视图
@property (nonatomic, strong) UIView *headerView;
//** 游戏规则遮罩视图
@property (nonatomic, strong) UIView *ruleBgView;
//** 记录中了什么奖
@property (nonatomic, assign) float startRank;
//** 网络请求页数
@property (nonatomic, assign) NSInteger page;
//** 数据源
@property (nonatomic, strong) NSArray *tepArray;
@property (nonatomic, strong) NSMutableArray *allArray;
//** 抽奖次数
@property (nonatomic, strong) UILabel *rotateTimesLable;
//** 定时器
@property (nonatomic, strong) NSTimer *rotateTimer;

@property (nonatomic, assign) CGFloat wScreen;
@property (nonatomic, assign) CGFloat hScreen;

@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rotateBgImg"]];
    self.title = @"大转盘";

    [self setUpUI];
    
    [self getData];
    
}

//** 初始化控件
-(void)setUpUI{
    
    CGFloat yOrigin = 0;
    CGFloat wScreen = [UIScreen mainScreen].bounds.size.width;
    CGFloat hScreen = [UIScreen mainScreen].bounds.size.height;
    self.wScreen = wScreen;
    self.hScreen = hScreen;
    
    //** 底部可滑动的scrollView视图
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yOrigin, wScreen, hScreen)];
    bgScrollView.contentSize = CGSizeMake(wScreen, 800);
    [self.view addSubview:bgScrollView];
    
    yOrigin = yOrigin + 20;
    
    //** 顶部文字视图
    UIImageView *topTextImgView = [[UIImageView alloc] initWithFrame:CGRectMake(wScreen/2-135, yOrigin, 270, 80)];
    topTextImgView.image = [UIImage imageNamed:@"topTextImg"];
    [bgScrollView addSubview:topTextImgView];
    
    yOrigin = yOrigin + 80 + 10;
    
    //** 大转盘视图
    self.rotateImgView = [[UIImageView alloc] initWithFrame:CGRectMake(wScreen/2-140, yOrigin, 280, 280)];
    self.rotateImgView.image = [UIImage imageNamed:@"rotateCycleIcon"];
    [bgScrollView addSubview:self.rotateImgView];
    
    //** 大转盘指针视图
    UIImageView *pointerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 120)];
    pointerImgView.center = self.rotateImgView.center;
    pointerImgView.image = [UIImage imageNamed:@"rotatePointer"];
    [bgScrollView addSubview:pointerImgView];
    
    //** 奖池视图
    UIImageView *awardImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    awardImgView.center = CGPointMake(self.rotateImgView.center.x, self.rotateImgView.center.y+15);
    awardImgView.image = [UIImage imageNamed:@"awardPool"];
    [bgScrollView addSubview:awardImgView];
    
    //** 奖池金额标签
    self.awardValueLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 12)];
    self.awardValueLable.center = CGPointMake(self.rotateImgView.center.x, awardImgView.center.y+10);
    self.awardValueLable.text = @"$500万";
    self.awardValueLable.textColor = [UIColor colorWithRed:255/255. green:241/255. blue:211/255. alpha:1];
    self.awardValueLable.font = [UIFont boldSystemFontOfSize:12];
    self.awardValueLable.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:self.awardValueLable];
    
    yOrigin = yOrigin + 280 + 10;
    
    //** 开始按钮
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton.frame = CGRectMake(wScreen/2-75, yOrigin, 150, 45);
    [self.startButton setBackgroundImage:[UIImage imageNamed:@"startBgImg"] forState:UIControlStateNormal];
    [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor colorWithRed:208/255. green:93/255. blue:0/255. alpha:1] forState:UIControlStateNormal];
    self.startButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:self.startButton];
    
    //** 游戏规则按钮
    UIButton *ruleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ruleButton.frame = CGRectMake(wScreen/2+75, yOrigin+25, 100, 20);
    [ruleButton setTitle:@"游戏规则" forState:UIControlStateNormal];
    [ruleButton setTitleColor:[UIColor colorWithRed:255/255. green:238/255. blue:201/255. alpha:1] forState:UIControlStateNormal];
    ruleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [ruleButton addTarget:self action:@selector(ruleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:ruleButton];
    
    //** 抽奖次数
    self.rotateTimesLable = [[UILabel alloc] initWithFrame:CGRectMake(wScreen/2+75, yOrigin-30, 100, 30)];
    self.rotateTimesLable.text = @"抽奖次数:N次";
    self.rotateTimesLable.textColor = [UIColor whiteColor];
    self.rotateTimesLable.font = [UIFont systemFontOfSize:12];
    [bgScrollView addSubview:self.rotateTimesLable];
    
    yOrigin = yOrigin + 45 + 20;
    
    //** 开奖记录视图
    UIImageView *recordNameImgView = [[UIImageView alloc] initWithFrame:CGRectMake(wScreen/2-110, yOrigin, 220, 35)];
    recordNameImgView.image = [UIImage imageNamed:@"rotateRecordNameIcon"];
    [bgScrollView addSubview:recordNameImgView];
    
    yOrigin = yOrigin + 35 + 10;
    
    //** 文字轮播图
    self.titleCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, yOrigin, wScreen, 20)];
    self.titleCycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    self.titleCycleScrollView.titleLabelTextColor = [UIColor whiteColor];
    self.titleCycleScrollView.titleLabelTextAlignment = NSTextAlignmentCenter;
    self.titleCycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:12];
    self.titleCycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.titleCycleScrollView.onlyDisplayText = YES;
    self.titleCycleScrollView.delegate = self;
    [bgScrollView addSubview:self.titleCycleScrollView];
    
    yOrigin = yOrigin + 20 + 10;
    
    //** 开奖记录列表
    self.winRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, yOrigin, wScreen-20, 210)];
    self.winRecordTableView.backgroundColor = [UIColor clearColor];
    self.winRecordTableView.delegate = self;
    self.winRecordTableView.dataSource = self;
    self.winRecordTableView.showsVerticalScrollIndicator = NO;
    self.winRecordTableView.showsHorizontalScrollIndicator = NO;
    self.winRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.winRecordTableView registerClass:[RotateRecordTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [bgScrollView addSubview:self.winRecordTableView];
    
    //** 布局表头
    [self setHeaderView];
    
    //** 游戏规则遮罩视图
    self.ruleBgView = [[UIView alloc] initWithFrame:self.view.frame];
    self.ruleBgView.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.6];
    [self.view addSubview:self.ruleBgView];
    self.ruleBgView.hidden = YES;
    
    UITapGestureRecognizer *ruleBgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ruleBgViewTapClick)];
    [self.ruleBgView addGestureRecognizer:ruleBgViewTap];
    
    //** 游戏规则视图
    UIImageView *ruleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, wScreen-20, 230)];
    ruleImgView.center = self.ruleBgView.center;
    ruleImgView.image = [UIImage imageNamed:@"rotateRule"];
    [self.ruleBgView addSubview:ruleImgView];

}

//** 布局表头
-(void)setHeaderView{
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.wScreen-20, 30)];
    self.headerView.backgroundColor = [UIColor colorWithRed:37/255. green:23/255. blue:112/255. alpha:1];
    self.winRecordTableView.tableHeaderView = self.headerView;
    
    //** 玩家标签
    UILabel *playerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (self.wScreen-20)/3, 30)];
    playerLable.text = @"玩家";
    playerLable.textColor = [UIColor whiteColor];
    playerLable.font = [UIFont systemFontOfSize:14];
    playerLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:playerLable];
    
    //** 时间标签
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake((self.wScreen-20)/3, 0, (self.wScreen-20)/3, 30)];
    timeLable.text = @"时间";
    timeLable.textColor = [UIColor whiteColor];
    timeLable.font = [UIFont systemFontOfSize:14];
    timeLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:timeLable];
    
    //** 结果标签
    UILabel *resultLable = [[UILabel alloc] initWithFrame:CGRectMake((self.wScreen-20)*2/3, 0, (self.wScreen-20)/3, 30)];
    resultLable.text = @"结果";
    resultLable.textColor = [UIColor whiteColor];
    resultLable.font = [UIFont systemFontOfSize:14];
    resultLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:resultLable];
    
}

//** 点击了返回按钮
-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//** 点击了开始按钮
-(void)startButtonClick{
    //** 进行开始转盘网络请求
    [self goRotateStartNetWork];
}

//** 开始大转盘旋转
-(void)startRotateWithRank:(int)rank{
    //** 根据奖项来赋值弧度
    switch (rank) {
        case 1:
            self.startRank = 9.0/5.0;
            break;
        case 2:
            self.startRank = 1.0/5.0;
            break;
        case 3:
            self.startRank = 1.0/2.0;
            break;
        case 4:
            self.startRank = 3.0/4.0;
            break;
        case 5:
            self.startRank = 5.0/5.0;
            break;
        case 6:
            self.startRank = 6.0/5.0;
            break;
        case 7:
            self.startRank = 7.0/5.0;
            break;
        case 8:
            self.startRank = 8.0/5.0;
            break;
            
        default:
            break;
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(-M_PI*4 - M_PI*(self.startRank));
    animation.duration = 5;
    animation.repeatCount = 1;
    animation.autoreverses = NO;
    animation.delegate = self;
    // 先加速后减速
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    // 动画结束后显示结束位置
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.rotateImgView.layer addAnimation:animation forKey:@"aa"];
}

//** 动画开始时
-(void)animationDidStart:(CAAnimation *)anim{
    self.startButton.userInteractionEnabled = NO;
}

//** 动画结束时
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.startButton.userInteractionEnabled = YES;
    //** 刷新记录列表
//    self.page = 0;
//    [self.allArray removeAllObjects];
//    [self goRotateRecordNetWork];
//    //** 大转盘奖金池金额网络请求
//    [self goAllAwardValueNetWork];
    
}

//** 点击了游戏规则
-(void)ruleButtonClick{
    [UIView animateWithDuration:1 animations:^{
        self.ruleBgView.hidden = NO;
    }];
}

//** 点击了游戏规则背景视图
-(void)ruleBgViewTapClick{
    [UIView animateWithDuration:1 animations:^{
        self.ruleBgView.hidden = YES;
    }];
}

//** 懒加载文字轮播数据源
-(NSArray *)titleArray{
    if (_titleArray == nil) {
        //        _titleArray = [NSArray arrayWithObjects:@"***354玩家抽到了超级大奖", @"***354玩家获得了$1000", nil];
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

//** 返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allArray.count;
}

//** 返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

//** 展示cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RotateRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    RotateRecordModel *model = self.allArray[indexPath.row];
    [cell setDataWithModel:model row:indexPath.row];
    return cell;
}

//** 请求下来的数据源
-(NSArray *)tepArray{
    if (_tepArray == nil) {
        _tepArray = [NSArray array];
    }
    return _tepArray;
}
//** 总数据源
-(NSMutableArray *)allArray{
    if (_allArray == nil) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

//** 大转盘开始网络请求
-(void)goRotateStartNetWork{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    [[NetworkHelper shareNetworkHelper] GETrequestInfoWithURL:[NSString stringWithFormat:@"%@%@", kPreURL,kplay_turntable] params:@{@"userid":getUser_id, @"privatekey":getUser_PrivateKey} complete:^(id responseObject) {
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //
    //        NSString *result = responseObject[@"result"];
    //        NLog(@"大转盘开始成功:%@", responseObject);
    //        if (result.integerValue == 100) {
    //            NSArray *array = responseObject[@"data"];
    //            StartResultModel *model = [[StartResultModel alloc] initWithDictionary:array[0] error:nil];
    //            [self startRotateWithRank:model.rank];
    //
    //        } else {
    //            [LYTool showAlertWithTitle:[NSString stringWithFormat:@"%@", responseObject[@"data"]]];
    //        }
    //    } fail:^(NSError *fail) {
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        NLog(@"大转盘开始失败:%@", fail);
    //    }];
    [self startRotateWithRank:arc4random()%8+1];
    
}

-(void)getData{
    // 中奖纪录列表数据源
    NSDictionary *dict = @{@"account":@"19913798773", @"create_time":@"878755765", @"get_money":@"100", @"cost_money":@"5"};
    for (int i = 0; i < 15; i++) {
        [self.allArray addObject:[[RotateRecordModel alloc] initWithDict:dict]];
    }
    [self.winRecordTableView reloadData];
    
    // 大奖轮播图数据源
    NSArray *array = @[@"柱子中了200万", @"高彩中了150万", @"小焕中了500万"];
    self.titleCycleScrollView.titlesGroup = array;

}


@end

//
//  RankViewController.m
//  RotateDemo
//
//  Created by LIHH on 2020/2/19.
//  Copyright © 2020 lyz. All rights reserved.
//

#import "RankViewController.h"

#import "RankTableViewCell.h"
#import "RankModel.h"

//** RGB颜色宏定义
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

static NSString *cellIdentifier = @"cellIdentifier";

@interface RankViewController ()<UITableViewDelegate, UITableViewDataSource>

//** 今日排行榜列表
@property (nonatomic, strong) UITableView *rankTableView;

//** 数据源
@property (nonatomic, strong) NSMutableArray *allArray;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:37/255. green:23/255. blue:112/255. alpha:1];
    
    // 导航栏设置为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    // 导航栏中间title为白色
    self.navigationItem.title = @"今日排行榜";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self setUpUI];
    
    //** 进入页面进行网络请求
    [self getBankListNet];

    
}

//** 初始化控件
-(void)setUpUI{
    
    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height == 20 ? 64 : 84;
    
    //** 无效成员列表
    self.rankTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-y)];
    self.rankTableView.backgroundColor = RGBA(31, 26, 93, 1);
    self.rankTableView.layer.borderColor = RGBA(24, 47, 121, 1).CGColor;
    self.rankTableView.layer.borderWidth = 1;
    self.rankTableView.delegate = self;
    self.rankTableView.dataSource = self;
    self.rankTableView.showsVerticalScrollIndicator = NO;
    self.rankTableView.showsHorizontalScrollIndicator = NO;
    self.rankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rankTableView registerClass:[RankTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.rankTableView];

}

//** 返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allArray.count;
}

//** 返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//** 展示cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row < 3 ) {
        [cell setImageWithName:[NSString stringWithFormat:@"rank%ld", indexPath.row+1]];
    } else {
        [cell setNumWithNumber:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
    }
    
    [cell setDataWith:self.allArray[indexPath.row]];
    return cell;
}

//** 排行榜网络请求
-(void)getBankListNet{
    
    NSDictionary *dict = @{@"phone":@"19913897688", @"name":@"柱子", @"get_today":@"99"};
    for (int i = 0; i < 15; i++) {
        [self.allArray addObject:[[RankModel alloc] initWithDict:dict]];
    }
    [self.rankTableView reloadData];
}

//** 总数据源
-(NSMutableArray *)allArray{
    if (_allArray == nil) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}



@end

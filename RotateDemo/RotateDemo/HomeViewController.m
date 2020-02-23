//
//  HomeViewController.m
//  RotateDemo
//
//  Created by LIHH on 2020/2/19.
//  Copyright © 2020 lyz. All rights reserved.
//

#import "HomeViewController.h"

#import "RankViewController.h"
#import "RotateViewController.h"


@interface HomeViewController ()

@property (nonatomic, strong) UIButton *rankBtn;
@property (nonatomic, strong) UIButton *rotateBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"首页";
    
    [self setUpUI];
    
    
}

//** 初始化控件
-(void)setUpUI{
    
    self.rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rankBtn.backgroundColor = [UIColor grayColor];
    [self.rankBtn setTitle:@"排行榜" forState:UIControlStateNormal];
    [self.rankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rankBtn addTarget:self action:@selector(rankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rankBtn];
    
    self.rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rotateBtn.backgroundColor = [UIColor grayColor];
    [self.rotateBtn setTitle:@"大转盘" forState:UIControlStateNormal];
    [self.rotateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rotateBtn addTarget:self action:@selector(rotateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rotateBtn];
    
}

-(void)rankBtnClick{
    [self.navigationController pushViewController:[[RankViewController alloc] init] animated:YES];
}

-(void)rotateBtnClick{
    [self.navigationController pushViewController:[[RotateViewController alloc] init] animated:YES];
}


//** 布局frame
-(void)viewWillLayoutSubviews{
    
    CGFloat sW = self.view.bounds.size.width;
    CGFloat sH = self.view.bounds.size.height;
    
    self.rankBtn.frame = CGRectMake(50, sH/2-50, sW-100, 50);
    self.rotateBtn.frame = CGRectMake(50, sH/2+50, sW-100, 50);
    
}


@end

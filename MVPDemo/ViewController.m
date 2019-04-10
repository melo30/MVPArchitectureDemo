//
//  ViewController.m
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import "ViewController.h"
#import "MVPViewController.h"
#import "MVVMViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UIButton *goodByeDotaButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _goodByeDotaButton = [UIButton new];
    [_goodByeDotaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_goodByeDotaButton setTitle:@"点我！" forState:UIControlStateNormal];
    [self.view addSubview:_goodByeDotaButton];
    _goodByeDotaButton.frame = CGRectMake(100, 100, 100, 100);
    [_goodByeDotaButton addTarget:self action:@selector(buttonEventHandle:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonEventHandle:(UIButton *)sender {
    //        MVPViewController *mvpVc = [[MVPViewController alloc] init];
    //        [self.navigationController pushViewController:mvpVc animated:YES];
    
        MVVMViewController *mvvmVc = [[MVVMViewController alloc] init];
        [self.navigationController pushViewController:mvvmVc animated:YES];
}

@end

//
//  ViewController.m
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import "ViewController.h"
#import "MVPViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UIButton *goodByeDotaButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MVPViewController *mvpVc = [[MVPViewController alloc] init];
        [self.navigationController pushViewController:mvpVc animated:YES];
    });
}


@end

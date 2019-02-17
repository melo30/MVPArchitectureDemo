//
//  MVPViewController.m
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import "MVPViewController.h"
#import "MVPTableViewCell.h"
#import "Model.h"
#import "MeloDataSource.h"
#import "Presenter.h"
@interface MVPViewController () <PresentDelegate>

/** 用来存放处理tableView的代理方法，给Controller瘦身 */
@property (nonatomic, strong) MeloDataSource *dataSouce;
@property (nonatomic, strong) Presenter *presenter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVP架构";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.初始化最关键的Presenter,数据的来源就在它里面,是为后面各种类提供操作的根源
    self.presenter = [[Presenter alloc] init];
    self.presenter.delegate = self;
    __weak typeof(self)weakSelf = self;
    self.dataSouce = [[MeloDataSource alloc] initWithIdentifier:NSStringFromClass([MVPTableViewCell class]) configureBlock:^(MVPTableViewCell *  _Nonnull cell, Model *  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        cell.nameLabel.text = model.name;
        cell.numLabel.text  = model.num;
        cell.indexPath = indexPath; // 比如:这里得indexPath,相当于是通过MeloDataSource从tableViewCell代理方法里面传过来，这里又传进View中去
        cell.delegate = weakSelf.presenter;// 让Presenter作为View的代理，因为Presenter中存放的数据，这样就能实现View改变通知Model改变啦~
    } selectBlock:^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"你当前点击了%ld行的cell",indexPath.row);
    }];
    //2.将presenter中的数据传递到MeloDataSource 中去展示
    [self.dataSouce addDataArray:self.presenter.dataArray];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self.dataSouce;
    self.tableView.dataSource = self.dataSouce;
}

#pragma mark - PresentDelegate
- (void)reloadDataForUI {
    [self.dataSouce addDataArray:self.presenter.dataArray];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[MVPTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MVPTableViewCell class])];
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

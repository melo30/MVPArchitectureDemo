//
//  MVVMViewController.m
//  MVPDemo
//
//  Created by 陈诚 on 2019/2/17.
//  Copyright © 2019 陈诚. All rights reserved.
//

#import "MVVMViewController.h"
#import "MeloDataSource.h"
#import "MVPTableViewCell.h"
#import "Model.h"
#import "MVVMViewModel.h"

@interface MVVMViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MVVMViewModel *vm;
@property (nonatomic, strong) MeloDataSource *dataSource;
@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"合计：" style:UIBarButtonItemStyleDone target:self action:nil];
    
    __weak typeof(self)weakSelf = self;
    
    
    self.dataSource = [[MeloDataSource alloc] initWithIdentifier:NSStringFromClass([MVPTableViewCell class]) configureBlock:^(MVPTableViewCell * _Nonnull cell, Model * _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        cell.nameLabel.text = model.name;
        cell.numLabel.text  = model.num;
        cell.num = [model.num integerValue];
        cell.indexPath      = indexPath;
        cell.delegate       = weakSelf.vm;
    } selectBlock:^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了%ld行cell", (long)indexPath.row);
    } reloadData:^(NSMutableArray * _Nonnull array) {
        weakSelf.vm.dataArray = array;
    }];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    
    //viewModel的操作
    self.vm = [[MVVMViewModel alloc] init];
    [self.vm initWithBlock:^(id data) {
        weakSelf.dataSource.dataArray = [weakSelf.vm.dataArray mutableCopy];
        [weakSelf.tableView reloadData];
        weakSelf.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"合计:%ld",weakSelf.vm.total];
    } failBlock:nil];
    
    //加载数据
    [self.vm loadData];
}

#pragma mark lazy
- (UITableView *)tableView{
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

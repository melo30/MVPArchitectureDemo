//
//  MeloDataSource.m
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import "MeloDataSource.h"

@interface MeloDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBeforeBlock cellConfigureBefore;

@property (nonatomic, copy) selectCellBlock selectBlock;

@property (nonatomic, copy) reloadDataBlock reloadData;
@end

@implementation MeloDataSource

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBeforeBlock)before selectBlock:(selectCellBlock)selectBlock reloadData:(reloadDataBlock)reloadData{
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _selectBlock = [selectBlock copy];
        _reloadData = [reloadData copy];
    }
    return self;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return !self.dataArray? 0 : self.dataArray.count; // 容错处理,防止崩溃😖
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    if(self.cellConfigureBefore) { //这里会调到Controller里面做cell的展示逻辑，cell的展示逻辑不写在这里原因是这个我们要保证MeloDataSource类的干净整洁，不耦合cell和model~
        self.cellConfigureBefore(cell, model,indexPath);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectBlock(indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self)weakSelf = self;
    //添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //在这里添加事件
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        weakSelf.reloadData(weakSelf.dataArray);
        NSLog(@"删除");
    }];
    return @[deleteRowAction];
}

#pragma mark - Custom
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}

- (void)addDataArray:(NSArray *)datas {
    if(!datas) return;
    
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:datas];
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}
@end

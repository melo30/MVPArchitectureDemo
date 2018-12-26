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

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;

@property (nonatomic, copy) selectCell selectBlock;

@end

@implementation MeloDataSource

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock {
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _selectBlock = [selectBlock copy];
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

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}



#pragma mark - Custom
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

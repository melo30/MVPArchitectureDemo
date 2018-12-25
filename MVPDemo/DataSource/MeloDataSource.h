//
//  MeloDataSource.h
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
@interface MeloDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

//全能初始化方法
- (instancetype)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before;

// 接收外界传过来的数据的全局操作变量
@property (nonatomic, strong) NSMutableArray *dataArray;

// 提供一个对外的入口，用来接收Presenter 传过来的数据，展示在tableView上面
- (void)addDataArray:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END

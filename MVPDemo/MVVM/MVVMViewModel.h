//
//  MVVMViewModel.h
//  MVPDemo
//
//  Created by 陈诚 on 2019/2/17.
//  Copyright © 2019 陈诚. All rights reserved.
//

#import "BaseViewModel.h"
#import "PresentDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : BaseViewModel <PresentDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

///刷新数据
- (void)loadData;

/// 计算总数
- (NSInteger)total;

@end

NS_ASSUME_NONNULL_END

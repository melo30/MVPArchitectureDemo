//
//  MVVMViewModel.m
//  MVPDemo
//
//  Created by 陈诚 on 2019/2/17.
//  Copyright © 2019 陈诚. All rights reserved.
//

#import "MVVMViewModel.h"
#import "Model.h"
@implementation MVVMViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ change",change[NSKeyValueChangeNewKey]);
    
    self.successBlock(change[NSKeyValueChangeNewKey]);
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"dataArray"];
}

- (void)loadData {
    dispatch_queue_t queue = dispatch_queue_create("udpios", DISPATCH_QUEUE_CONCURRENT);
    
    //异步执行任务
    dispatch_async(queue, ^{
        NSArray *temArray =
        @[
              @{@"name":@"影魔",@"imageUrl":@"http://CC",@"num":@"1"},
              @{@"name":@"圣堂刺客",@"imageUrl":@"http://CC",@"num":@"1"},
              @{@"name":@"撼地神牛",@"imageUrl":@"http://CC",@"num":@"1"},
              @{@"name":@"风行者",@"imageUrl":@"http://CC",@"num":@"1"},
              @{@"name":@"虚空假面",@"imageUrl":@"http://CC ",@"num":@"1"},
              @{@"name":@"风暴之灵",@"imageUrl":@"http://CC",@"num":@"1"},
              @{@"name":@"祈求着",@"imageUrl":@"http://CC",@"num":@"1"},
              @{@"name":@"火女",@"imageUrl":@"http://CC",@"num":@"1"}
         ];
        
        [self.dataArray removeAllObjects];
        for (int i = 0; i < temArray.count; i ++) {
            Model *m = [Model modelWithDictionary:temArray[i]];
            [self.dataArray addObject:m];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程更新代码
            self.successBlock(self.dataArray);
        });
    });
}

#pragma mark - PresentDelegate
- (void)didClickAddBtnWithNum:(NSString *)num indexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < self.dataArray.count; i ++) {
        if (i == indexPath.row) {
            Model *m = self.dataArray[indexPath.row];
            m.num = num;
            break;
        }
    }
    
    if ([num intValue] > 6) {
        NSArray *temArray =
        @[
            @{@"name":@"影魔",@"imageUrl":@"http://CC",@"num":@"6"},
            @{@"name":@"圣堂刺客",@"imageUrl":@"http://CC",@"num":@"6"},
            @{@"name":@"撼地神牛",@"imageUrl":@"http://CC",@"num":@"6"},
            @{@"name":@"风行者",@"imageUrl":@"http://CC",@"num":@"6"},
            @{@"name":@"虚空假面",@"imageUrl":@"http://CC ",@"num":@"6"},
            @{@"name":@"风暴之灵",@"imageUrl":@"http://CC",@"num":@"6"},
            @{@"name":@"祈求着",@"imageUrl":@"http://CC",@"num":@"6"},
            @{@"name":@"火女",@"imageUrl":@"http://CC",@"num":@"6"}
        ];
        [self.dataArray removeAllObjects];
        for (int i = 0; i < temArray.count; i++) {
            Model *m = [Model modelWithDictionary:temArray[i]];
            [self.dataArray addObject:m];
        }
    }
    
    self.successBlock(self.dataArray);
}

- (NSInteger)total {
    NSInteger total = 0;
    for (Model *dic in self.dataArray) {
        NSInteger num = [dic.num integerValue];
        total += num;
    }
    return total;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end

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
    self = [super init];
    if (self) {
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
          @{@"name":@"影魔",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"圣堂刺客",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"撼地神牛",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"风行者",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"虚空假面",@"imageUrl":@"http://CC ",@"num":@"9"},
          @{@"name":@"风暴之灵",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"祈求着",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"火女",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"精灵龙",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"黑曜毁灭者",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"哈斯卡",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"变体精灵",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"混沌骑士",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"幻影刺客",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"隐形刺客",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"月之女祭司",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"暗夜魔王",@"imageUrl":@"http://CC",@"num":@"9"},
          @{@"name":@"地穴编织者",@"imageUrl":@"http://CC ",@"num":@"9"}];
        
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
          @{@"name":@"Gxq",@"imageUrl":@"http://Gxq",@"num":@"9"},
          @{@"name":@"Gxq",@"imageUrl":@"http://Gxq",@"num":@"9"},
          @{@"name":@"Gxq",@"imageUrl":@"http://Gxq",@"num":@"9"}];
        [self.dataArray removeAllObjects];
        for (int i = 0; i < temArray.count; i++) {
            Model *m = [Model modelWithDictionary:temArray[i]];
            [self.dataArray addObject:m];
        }
    }
    
    self.successBlock(self.dataArray);
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end

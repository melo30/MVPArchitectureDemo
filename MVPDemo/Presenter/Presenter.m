//
//  Presenter.m
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import "Presenter.h"
#import "Model.h"

@implementation Presenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData]; //平时这块儿大概就是去网络请求些啥，可能还会涉及到参数的传递.
    }
    return self;
}

- (void)loadData {
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
    
    for (int i = 0; i < temArray.count; i ++) {
        Model *model = [Model modelWithDictionary:temArray[i]];
        [self.dataArray addObject:model];
    }
}

#pragma mark - lazyLoad

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end

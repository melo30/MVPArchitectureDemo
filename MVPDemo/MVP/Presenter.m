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
        @{@"name":@"影魔",@"imageUrl":@"http://CC",@"num":@"1"},
        @{@"name":@"圣堂刺客",@"imageUrl":@"http://CC",@"num":@"1"},
        @{@"name":@"撼地神牛",@"imageUrl":@"http://CC",@"num":@"1"},
        @{@"name":@"风行者",@"imageUrl":@"http://CC",@"num":@"1"},
        @{@"name":@"虚空假面",@"imageUrl":@"http://CC ",@"num":@"1"},
        @{@"name":@"风暴之灵",@"imageUrl":@"http://CC",@"num":@"1"},
        @{@"name":@"祈求着",@"imageUrl":@"http://CC",@"num":@"1"},
        @{@"name":@"火女",@"imageUrl":@"http://CC",@"num":@"1"}
    ];
    
    for (int i = 0; i < temArray.count; i ++) {
        Model *model = [Model modelWithDictionary:temArray[i]];
        [self.dataArray addObject:model];
    }
}

#pragma mark - PresenterDelegate
- (void)didClickAddBtnWithNum:(NSString *)num indexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < self.dataArray.count; i ++) {
        if (indexPath.row == i) {
            Model *model = self.dataArray[indexPath.row];
            model.num = num;
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
        for (int i = 0; i<temArray.count; i++) {
            Model *m = [Model modelWithDictionary:temArray[i]];
            [self.dataArray addObject:m];
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(reloadDataForUI)]) {
        //注解:
        // 一般处理完数据，我们就可以去刷新UI，看tableView放在哪个类里面(不一定在controller，其实也可以放在本类Presenter中，也可以放到MeloDataSource去，很灵活~),然后就去当前类遵循该协议实现reloadDataForUI协议方法 刷新tableView ~
        
        [_delegate reloadDataForUI];
    }
}

- (NSInteger)total {
    NSInteger total = 0;
    for (Model *dic in self.dataArray) {
        NSInteger num = [dic.num integerValue];
        total += num;
    }
    return total;
}

#pragma mark - lazyLoad

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}
@end

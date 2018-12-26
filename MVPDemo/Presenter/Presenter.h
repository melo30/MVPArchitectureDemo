//
//  Presenter.h
//  MVPDemo
//
//  Created by melo on 2018/12/25.
//  Copyright © 2018 陈诚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PresentDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject <PresentDelegate>

// 定义一个全局变量数组，用来接收比如网络请求得到的Model数组.
@property (nonatomic, strong) NSMutableArray *dataArray;

// 这里定义一个模拟数据的操作，根据需求定义，平时项目可以在本类中定义你的网络请求，得到数据，然后json转model的一系列操作...
- (void)loadData;

@property (nonatomic, weak) id <PresentDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
